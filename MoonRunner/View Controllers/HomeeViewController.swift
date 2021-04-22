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
import Firebase
import FirebaseFirestore
import SDWebImage


class HomeeViewController: UIViewController {

@IBOutlet weak var BackBtn: UIButton!
  
  @IBOutlet weak var FullNameTextField: UITextField!
  @IBOutlet weak var GenderTextField: UITextField!
  @IBOutlet weak var PhoneNumberTextField: UITextField!
  @IBOutlet weak var BioTextField: UITextField!
  @IBOutlet weak var BackButton: UIButton!
  @IBOutlet weak var ImageView: UIImageView!
  
  var user: User?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    fetchUserData()
  }
  

  @IBAction func backButtonPressed(_ sender: Any) {
    transitionToHome()
  }
  
  
  func fetchUserData() {
    AuthService.fetchUser { (user) in
      self.user = user
      self.FullNameTextField.text = self.user?.firstName
      self.BioTextField.text  = self.user?.email
      self.ImageView.sd_setImage(with: URL(string: self.user!.profileImageUrl))
      self.GenderTextField.text = self.user?.lastName
    }
  }
  
  func transitionToHome() {
      
      let homeeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
      
      view.window?.rootViewController = homeeViewController
      view.window?.makeKeyAndVisible()
      
  }
  
  func validateFields() -> String? {
    
    // Check that all fields are filled in
    if FullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        GenderTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        PhoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        BioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
        return "Please fill in all fields."
    }
    return nil
    
  }
  
  @IBAction func backGotTapped(_ sender: Any) {
    
    
  }
  
  @IBAction func SaveTapped(_ sender: Any) {
    // Validate the fields
    let error = validateFields()
    
    if error != nil {
        
        // There's something wrong with the fields, show error message
       // showError(error!)
    }
    else {
        
        // Create cleaned versions of the data
        let firstname = FullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastname = GenderTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Email = PhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Password = BioTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
       Auth.auth().createUser(withEmail: Email, password: Password) { (result, err) in
            
            // Check for errors
           
                
                // User was created successfully, now store the first name and last name
              let db = Firestore.firestore()
             
      let data: [String: Any] = ["FullName": firstname, "Gender": lastname, "PhoneNum": Email, "Bio": Password ]

        db.collection("Profile").document(result!.user.uid).setData(data){ (error) in
             // db.collection("users").document(result!.user.uid).setD(data: ["firstName": firstname, "lastName":lastname]) { (error) in
                    
                    if error != nil {
                        // Show error message
                       // self.showError("Error saving user data")
                    }
                }
                
            }
            
        }
        
        
        
    }
  
  
  
}
//extension HomeeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
//{
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    if let image = info[ UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage") ] as? UIImage
//    {
//      ImageView.image = image
//    }
//    picker.dismiss(animated: true, completion: nil)
//
//  }
//  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    picker.dismiss(animated: true, completion: nil)
//  }
//
//}
