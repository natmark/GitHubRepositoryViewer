//
//  ViewController.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/03.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import APIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = FetchRepositoryRequest(userName: "natmark")
        Session.send(request) { result in
            switch result {
            case .success(let repositories):
                print(repositories)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
