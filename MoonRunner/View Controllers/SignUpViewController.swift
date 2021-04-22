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
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    
  @IBOutlet weak var ImagePicker: UIImageView!
  @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpElements()
        
    }
  
  
  func setUpElements() {
  
      // Hide the error label
      errorLabel.alpha = 0
  
      // Style the elements
      Utilities.styleTextField(firstNameTextField)
      Utilities.styleTextField(lastName)
      Utilities.styleTextField(email)
      Utilities.styleTextField(password)
      Utilities.styleFilledButton(signUp)
  }
  
  func validateFields() -> String? {
      
      // Check that all fields are filled in
      if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
          
          return "Please fill in all fields."
      }
      
      // Check if the password is secure
      let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      if Utilities.isPasswordValid(cleanedPassword) == false {
          // Password isn't secure enough
          return "Please make sure your password is at least 8 characters, contains a special character and a number."
      }
      
      return nil
  }
  
  
  @IBAction func ImageGotTapped(_ sender: Any) {
    
    let vc = UIImagePickerController()
    vc.sourceType = .photoLibrary
    vc.delegate = self
    vc .allowsEditing = true
    present(vc, animated: true)
  }
  @IBAction func signupTapped(_ sender: Any) {
      
    
      // Validate the fields
      let error = validateFields()
      
      if error != nil {
          
          // There's something wrong with the fields, show error message
          showError(error!)
      }
      else {
          
          // Create cleaned versions of the data
          let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          let lastname = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          let Email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          let Password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let image = ImagePicker.image!
        let credental = AuthCredentials(email: Email, password: Password, firstName: firstname, lastName: lastname, profileImage: image)
        AuthService.registerUser(withCredentials: credental) { (err) in
          // next page
          
          
        }
        self.transitionToHome()
        
        
          // Create the user
//          Auth.auth().createUser(withEmail: Email, password: Password) { (result, err) in
//
//              // Check for errors
//              if err != nil {
//
//                  // There was an error creating the user
//                  self.showError("Error creating user")
//              }
//              else {
//
//                  // User was created successfully, now store the first name and last name
//                let db = Firestore.firestore()
//
//                let data: [String: Any] = ["firstName": firstname, "lastName": lastname]
//
//                db.collection("users").document(result!.user.uid).setData(data){ (error) in
//               // db.collection("users").document(result!.user.uid).setD(data: ["firstName": firstname, "lastName":lastname]) { (error) in
//
//                      if error != nil {
//                          // Show error message
//                          self.showError("Error saving user data")
//                      }
//                  }
//
//                  // Transition to the home screen
//                  self.transitionToHome()
//              }
//              
//          }
          
          
          
      }
  }

      
    
func showError(_ message:String) {
    
  errorLabel.text = message
  errorLabel.alpha = 1
}

func transitionToHome() {
    
    let homeeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeeViewController
    
    view.window?.rootViewController = homeeViewController
    view.window?.makeKeyAndVisible()
    
}

}
extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    if let image = info[ UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage") ] as? UIImage
    {
      ImagePicker.image = image
    }
    picker.dismiss(animated: true, completion: nil)

  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}


    


