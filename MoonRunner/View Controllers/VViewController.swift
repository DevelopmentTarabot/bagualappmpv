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

import UIKit
import AVKit
import Firebase


class VViewController: UIViewController {
//  var videoPlayerLayer:AVPlayerLayer?
//  var videoPlayer:AVPlayer?

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      if Auth.auth().currentUser != nil {
        let homeeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeeViewController
        
        self.view.window?.rootViewController = homeeViewController
        self.view.window?.makeKeyAndVisible()
      }
     setUpElements()
    }
//  override func viewWillAppear(_ animated: Bool) {
      
      // Set up video in the background
//      setUpVideo()
//  }
//  func setUpVideo() {
//    // Get the path to the resource in the bundle
//    let bundlePath = Bundle.main.path(forResource: "Dirty_Horse", ofType: "mp4")
//
//    guard bundlePath != nil else {
//        return
//    }
//
//    // Create a URL from it
//    let url = URL(fileURLWithPath: bundlePath!)
//
//    // Create the video player item
//    let item = AVPlayerItem(url: url)
//
//    // Create the player
//    videoPlayer = AVPlayer(playerItem: item)
//
//    // Create the layer
//    videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
//
//    // Adjust the size and frame
//    videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
//
//    view.layer.insertSublayer(videoPlayerLayer!, at: 0)
//
//    // Add it to the view and play it
//    videoPlayer?.playImmediately(atRate: 0.3)
//
//  }
  
  func setUpElements() {
      
      // Style the elements
    Utilities.styleFilledButton(login)
    
    Utilities.styleFilledButton(signUp)
    
  }
  
  
  
    

}
