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
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
    }
  
  func setUpElements() {
      
      // Hide the error label
      errorLabel.alpha = 0
      
      // Style the elements
      Utilities.styleTextField(email)
      Utilities.styleTextField(password)
      Utilities.styleFilledButton(login)
      
  }
    
    @IBAction func loginTapped(_ sender: Any) {
      // TODO: Validate Text Fields
      
      // Create cleaned versions of the text field
      let Email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let Password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      // Signing in the user
      Auth.auth().signIn(withEmail: Email, password: Password) { (result, error) in
          
          if error != nil {
              // Couldn't sign in
              self.errorLabel.text = error!.localizedDescription
              self.errorLabel.alpha = 1
          }
          else {

              let homeeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeeViewController

            self.view.window?.rootViewController = homeeViewController
              self.view.window?.makeKeyAndVisible()
          }
      }
  }
    
    
    
    
}
