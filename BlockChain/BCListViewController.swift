//
//  BCListViewController
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

final class BCListViewController: UITableViewController {

    struct Constants {
        static let cellIdentifire = "BaseCell"
        static let footerHeight = 50
    }
    
    var viewPresenter: BCListViewModel!
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Latest Blocks"
        self.refreshControl = {
            let control = UIRefreshControl()
            control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            return control
        }()
        
        //self.tableView.tableFooterView = paginationIndicatorView
        
    }
    
    
    @objc private func refreshData() {
        // check for new block add on top
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire, for: indexPath)
//        let cellViewModel = viewModel.cellViewModel(row: indexPath.row)
//        cell.textLabel?.text = cellViewModel.job
//        cell.textLabel?.numberOfLines = 0
//        cell.detailTextLabel?.text = cellViewModel.salary
//        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   0//viewModel.cellCount
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = JobDetailViewController()
//        vc.viewModel = JobDetailViewViewModel(jobDetail: viewModel.jobDataObject(row: indexPath.row))
    }
}


