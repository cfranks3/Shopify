//
//  CollectionDetailViewController.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import UIKit
import Imaginary

class CollectionDetailViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCollectionTitle: UILabel!
    
    @IBOutlet weak var lblCollectionDetail: UILabel!
    var collection:CollectionData?

    @IBOutlet weak var tableView: UITableView!{didSet{
        tableView.estimatedRowHeight = 100}}
    
    var dataSource : TableDataSource?{
        didSet{
            tableView.delegate = dataSource
            tableView.dataSource = dataSource
        }
    }
    

    var items = [Product](){didSet{
        dataSource?.items = items
        self.tableView?.reloadData()
        }}
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.api()
        let option = Option()
        self.lblCollectionTitle.text = collection?.title
        self.lblCollectionDetail.text = collection?.bodyHtml

        guard let imageUrl = URL(string:collection?.image?.src ?? "") else {
            return
        }
        img?.setImage(url: imageUrl, placeholder: nil, option: option) { (response) in
        }
        //var myarry = ["",""]
       // myarry.joined(separator: "")
        // Do any additional setup after loading the view.
    }
    

    
    func api() {
        APIManager.sharedInstance.opertationWithRequest(withApi: API.UserAPI(value: API.UserEnum.GetCollectionDetails(collectionId: collection?.id, page: "1"))) { (response) in
            switch response{
            case .Failure(_):
                print("error......")
            case .Success(let data):
                let res = data as? [CollectsModel] ?? []
                self.fetchProducts(ids: (res.map{$0.productId}).joined(separator: ","))
               
            }
        }
    }
    
    
    func fetchProducts(ids:String) {
        APIManager.sharedInstance.opertationWithRequest(withApi: API.UserAPI(value: API.UserEnum.GetCollectionProducts(productIds: ids, page: "1"))) { (response) in
            switch response{
            case .Failure(_):
                print("error......")
            case .Success(let data):
                self.items = data as? [Product] ?? []
                self.setupTableView()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: TableView
extension CollectionDetailViewController{
    
    func setupTableView() {
        dataSource = TableDataSource(items: items, height: UITableView.automaticDimension, tableView: tableView, cellIdentifier: "ListTableViewCell", configureCellBlock: { (cell, item, index) in
            self.configureTableCell(cell: cell, item: item,index: index)
        }, aRowSelectedListener: { (indexPath) in
            self.clickHandler(indexPath: indexPath)
        })
    }
    
    func clickHandler(indexPath : IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionDetailViewController") as? CollectionDetailViewController
//        vc?.collectionId = items[indexPath.row].id
//        self.present(vc ?? UIViewController(), animated: true) {}
    }
    
    func configureTableCell(cell : AnyObject?,item : AnyObject?,index : IndexPath?) {
        let cell = cell as? ListTableViewCell
        cell?.product = item as? Product
        //cell?.category = item as? Category
        
    }
}
