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

class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let viewModel = ListViewModel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self

        tableView.dataSource = viewModel

        bind()
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

        //search
        searchBar.rx.text
            .subscribe(onNext: { [unowned self] q in
                self.navigationItem.title = q!
                self.viewModel.reloadData(userName: q!)
            }, onError: { error in
            }, onCompleted: { () in
            }, onDisposed: { () in
            }).addDisposableTo(disposeBag)
    }
    // MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    // MARK: - SearchBar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
