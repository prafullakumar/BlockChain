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
        viewPresenter.refresh()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire) ?? {
            //if nil configure new cell
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: Constants.cellIdentifire)
            cell.textLabel?.numberOfLines = 0
            cell.accessoryType = .disclosureIndicator
            cell.detailTextLabel?.numberOfLines = 0
            return cell
        }()
        
        let cellViewModel = viewPresenter.cellDataModel(index: indexPath.row)
        cell.textLabel?.text = cellViewModel.producer
        cell.detailTextLabel?.text = cellViewModel.identifier
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewPresenter.cellCount
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BCDetailViewController()
        vc.viewPresenter = BCDetailViewModel(data: viewPresenter.cellData(index: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension BCListViewController: ViewControllerUpdateDelegate {
    func viewModel(didUpdateState state: ViewModelState) {
        switch state {
        case .loadFail(let error):
            refreshControl?.endRefreshing()
            tableView.reloadData()
            let alert = UIAlertController(title: "Error!",
                                          message: error,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .loadSuccess:
            refreshControl?.endRefreshing()
            tableView.reloadData()
        default:
            break
        }
    }
}
