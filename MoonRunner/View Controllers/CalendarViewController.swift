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

import UserNotifications
import UIKit

class CalendarViewController: UIViewController {

  @IBOutlet weak var table: UITableView!
  
  var models = [MyReminder]()

  override func viewDidLoad() {
      super.viewDidLoad()
      table.delegate = self
      table.dataSource = self
  }

  @IBAction func didTapAdd() {
      // show add vc
      guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
          return
      }

      vc.title = "New Reminder"
      vc.navigationItem.largeTitleDisplayMode = .never
      vc.completion = { title, body, date in
          DispatchQueue.main.async {
              self.navigationController?.popToRootViewController(animated: true)
              let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
              self.models.append(new)
              self.table.reloadData()

              let content = UNMutableNotificationContent()
              content.title = title
              content.sound = .default
              content.body = body

              let targetDate = date
              let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                        from: targetDate),
                                                          repeats: false)

              let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
              UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                  if error != nil {
                      print("something went wrong")
                  }
              })
          }
      }
      navigationController?.pushViewController(vc, animated: true)

  }

  @IBAction func didTapTest() {
      // fire test notification
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
          if success {
              // schedule test
              self.scheduleTest()
          }
          else if error != nil {
              print("error occurred")
          }
      })
  }

  func scheduleTest() {
      let content = UNMutableNotificationContent()
      content.title = "Hello World"
      content.sound = .default
      content.body = "My long body. My long body. My long body. My long body. My long body. My long body. "

      let targetDate = Date().addingTimeInterval(10)
      let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                from: targetDate),
                                                  repeats: false)

      let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
          if error != nil {
              print("something went wrong")
          }
      })
  }

}

extension CalendarViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
  }

}


extension CalendarViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
      return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = models[indexPath.row].title
      let date = models[indexPath.row].date

      let formatter = DateFormatter()
      formatter.dateFormat = "MMM, dd, YYYY"
      cell.detailTextLabel?.text = formatter.string(from: date)

      cell.textLabel?.font = UIFont(name: "Arial", size: 25)
      cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
      return cell
  }

}


struct MyReminder {
  let title: String
  let date: Date
  let identifier: String
}
