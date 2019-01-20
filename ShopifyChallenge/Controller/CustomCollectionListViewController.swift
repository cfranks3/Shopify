//
//  CustomCollectionListViewController.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 18/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import UIKit

class CustomCollectionListViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!{didSet{
        tableView.estimatedRowHeight = 100}}
    
    var dataSource : TableDataSource?{
        didSet{
            tableView.delegate = dataSource
            tableView.dataSource = dataSource
        }
    }
    
  
    var items = [CollectionData](){didSet{
        dataSource?.items = items
        self.tableView?.reloadData()
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api();
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func api() {
        APIManager.sharedInstance.opertationWithRequest(withApi: API.UserAPI(value: API.UserEnum.GetCustomCollections(page: "1"))) { (response) in
            switch response{
            case .Failure(_):
                print("error......")
            case .Success(let data):
                let res = data as? [CollectionData]
                self.items = res ?? []
            }
        }
    }

}


//MARK: TableView
extension CustomCollectionListViewController{
    
    func setupTableView() {
        dataSource = TableDataSource(items: items, height: UITableView.automaticDimension, tableView: tableView, cellIdentifier: "ListTableViewCell", configureCellBlock: { (cell, item, index) in
            self.configureTableCell(cell: cell, item: item,index: index)
        }, aRowSelectedListener: { (indexPath) in
            self.clickHandler(indexPath: indexPath)
        })
    }
    
    func clickHandler(indexPath : IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionDetailViewController") as? CollectionDetailViewController
        vc?.collection = items[indexPath.row]
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func configureTableCell(cell : AnyObject?,item : AnyObject?,index : IndexPath?) {
        let cell = cell as? ListTableViewCell
        cell?.data = item as? CollectionData
        //cell?.category = item as? Category
        
    }
}



