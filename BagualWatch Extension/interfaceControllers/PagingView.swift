//
/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SwiftUI

struct PagingView: View {
    // The business logic.
    @EnvironmentObject var workoutSession: WorkoutManager
    // The page you are showing the user.
    @State var pageSelection: PageSelection = .workout
    // Tracks whether a workout is in progress (paused or running), or not.
    @Binding var workoutInProgress: Bool
    
    // Page selection enum.
    enum PageSelection {
        case menu // Show the menu page.
        case workout // Show the workout page.
    }
    
    var body: some View {
        // A Page style tab view.
        TabView(selection: $pageSelection) {
            // The menu view.
            MenuView(pauseAction: pauseAction, endAction: endAction)
                .tag(PageSelection.menu)
            
            // The workout view.
            WorkoutView()
                .tag(PageSelection.workout)
        }.tabViewStyle(PageTabViewStyle())
    }
    
    // Callback provided to the pause menu button.
    func pauseAction() {
        withAnimation { self.pageSelection = .workout }
        workoutSession.togglePause()
    }
    
    // Callback provided to the end workout menu button.
    func endAction() {
        print("PageView got endAction()")
        // End the workout.
        workoutSession.endWorkout()
        
        // Make sure you arrive back on the WorkoutView the next time a workout starts.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.pageSelection = .workout
        }
        // Bring up StartView.
        workoutInProgress = false
    }
}

struct PagingView_Previews: PreviewProvider {
    @State static var workoutInProgress = true
    static var previews: some View {
        Group {
            PagingView(pageSelection: .menu, workoutInProgress: $workoutInProgress)
            .previewDisplayName("pageSelection: .menu")
                
            PagingView(pageSelection: .workout, workoutInProgress: $workoutInProgress)
            .previewDisplayName("pageSelection: .workout")
        }
        .environmentObject(WorkoutManager())
    }
}
