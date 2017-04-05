//
//  ListViewModel.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import RxSwift
import APIKit

/// List View Model
class ListViewModel: NSObject, UITableViewDataSource {

    /// Cell Identifier
    private var cellIdentifier = "ListCell"

    /// Entry
    private(set) var repos = Variable<[Repository]>([])

    /// Entry
    private(set) var error = Variable<Error?>(nil)

    let disposeBag = DisposeBag()

    override init() {
        super.init()
    }

    /**
     Reload
     */
    func reloadData() {
        let request = FetchRepositoryRequest(userName: "natmark")
        Session.rx_sendRequest(request: request)
            .subscribe {
                [weak self] event in
                switch event {
                case .next(let repos):
                   self?.repos.value = repos
                case .error(let error): break
                    self?.error.value = error
                default: break
                }
            }
            .addDisposableTo(disposeBag)
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ListCell
        cell.configureCell(repo: repos.value[indexPath.row])
        return cell
    }
}
