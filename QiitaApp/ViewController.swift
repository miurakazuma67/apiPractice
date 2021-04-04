//
//  ViewController.swift
//  QiitaApp
//
//  Created by 三浦　一真 on 2021/03/29.
//

import Foundation
import UIKit

struct Connpass: Codable {
    var events: [Event]?
    struct Event: Codable {
        var title: String?
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var connpass: Connpass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApi()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    private func getApi() {
        guard let url: URL = URL(string: "https://connpass.com/api/v1/event/?keyword=Swift") else {return}
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                let connpass = try JSONDecoder().decode(Connpass.self, from: data!)
                self.connpass = connpass
                DispatchQueue.main.async() { () -> Void in
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.label?.text = connpass?.events?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
