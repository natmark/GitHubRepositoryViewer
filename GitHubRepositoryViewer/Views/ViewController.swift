//
//  ViewController.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/03.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    /// View Model
    private let viewModel = ListViewModel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // ViewModel
        setupViewModel()

        // Rx
        bind()
    }

    func setupViewModel() {
        tableView.dataSource = viewModel
        tableView.delegate = self
        // Load
        viewModel.reloadData()
    }
    func bind() {
        // Connection
        viewModel.repos.asObservable().filter { x in
            return !x.isEmpty
            }.subscribe(onNext: { [unowned self] x in
                self.tableView.reloadData()
            }, onError: { error in
            }, onCompleted: { () in
            }, onDisposed: { () in
            }).addDisposableTo(disposeBag)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
