//
//  ViewController.swift
//  Call API
//
//  Created by le tuan anh on 8/21/19.
//  Copyright © 2019 CNTT-TDC. All rights reserved.
//

import UIKit

struct ResponseObject: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case completed = "completed"
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtTittle: UITextField!
    @IBOutlet weak var swCompleted: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url:String = "https://jsonplaceholder.typicode.com/todos/1?fbclid=IwAR07DUHEaO5AqxM1OuliRkbsaDVD1lJHo9_WRgjwRW9zqT2va_3IvyLof9Q"
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
            let decoder = JSONDecoder()
            
            var userId:Int?
            var id:Int?
            var title:String?
            var completed:Bool?
            
            do {
                let responseObject = try decoder.decode(ResponseObject.self, from: data)
                print(responseObject)
                userId = responseObject.userId
                id = responseObject.id
                title = responseObject.title
                completed = responseObject.completed
            } catch {
                print("ERROR: ")
                print(error)
            }
            
            DispatchQueue.main.async {
                self.txtUserId.text = String(userId!)
                self.txtId.text = String(id!)
                self.txtTittle.text = title
                if(completed)! {
                    self.swCompleted.isOn = true
                } else {
                    self.swCompleted.isOn = false
                }
            }
        }
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

