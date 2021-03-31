//
//  ViewController.swift
//  QiitaApp
//
//  Created by 三浦　一真 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var eventTitle: String = "" {
            didSet{
                tableView.reloadData()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL = URL(string: "https://connpass.com/api/v1/event/?keyword=Swift")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                let connpassData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
                print(connpassData)
                
                DispatchQueue.main.async() { () -> Void in
                self.eventTitle = connpassData["title"] as? String ?? ""
                                    }
                print(connpassData)
            }
            catch {
                print(error)
            }
        })
        task.resume()
        tableView.delegate = self
        tableView.dataSource = self
        // カスタムセルを登録する
               let nib = UINib(nibName: "TableViewCell", bundle: nil)
               tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.label?.text = self.eventTitle
            return cell
        }
    // セルの幅を80に設定
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
}
