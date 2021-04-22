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

struct Credentials{
    let type: String
    let Age: String
    let Name: String
    let profileImage: UIImage
  
}
struct Service{
    
    static func registerUser(withCredentials credentials: Credentials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.Name, password: credentials.Age) { (result, error) in
                if let error = error{
                    print("\(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return} ///user ID
                let data: [String: Any] = ["type": credentials.type,
                                           "name": credentials.Name,
                                           "age": credentials.Age,
                                           "profileImageURL": imageURL,
                                           "uid": uid]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)

            }
        }
    }
  
  
  
  static func fetchUser(completion: @escaping (hores) -> Void){
          guard let uid = Auth.auth().currentUser?.uid else {return}
          COLLECTION_HORES.document(uid).getDocument { (snapshop, error) in
              guard let dictionary = snapshop?.data() else {return}
              let horess = hores(dictionary: dictionary)
              completion(horess)
          }
      }
  
  
  
}

