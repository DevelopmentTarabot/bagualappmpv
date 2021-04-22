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
import CoreData
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class HoresInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

  @IBOutlet weak var tableView: UITableView!
  
  private let realm = try! Realm()
  private var data = [ToDoListItem]()
  
  
//  let Names = ["Raghad abushehadeh", "Samah Anwer", "Aseel Ahmad",  "salam adeeb", "Johan smith", "saaed salam" ]
  override func viewDidLoad() {
        super.viewDidLoad()
    data = realm.objects(ToDoListItem.self).map({ $0 })
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    // Do any additional setup after loading the view.
    }
  
  // Mark: Table

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = data[indexPath.row].item
      return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)

      // Open the screen where we can see item info and dleete
      let item = data[indexPath.row]

      guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else {
          return
      }

      vc.item = item
      vc.deletionHandler = { [weak self] in
          self?.refresh()
      }
    vc.navigationItem.largeTitleDisplayMode = .never
      vc.title = item.item
      navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func didTapAddButton() {
      guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
          return
      }
      vc.completionHandler = { [weak self] in
          self?.refresh()
      }
      vc.title = "New Horse"
      vc.navigationItem.largeTitleDisplayMode = .never
      navigationController?.pushViewController(vc, animated: true)
  }
  func refresh() {
      data = realm.objects(ToDoListItem.self).map({ $0 })
      tableView.reloadData()
  }


}
//extension HoresInfoViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("you tappde me!")
//  }
//}
//extension HoresInfoViewController: UITableViewDataSource {
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return Names.count
//  }
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    cell.textLabel? . text = Names[indexPath.row]
//    return cell
//
//  }
//
//}


