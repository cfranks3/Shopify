//
//  ListTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 18/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import UIKit
import Imaginary
import Material


class ListTableViewCell: TableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    
    var data : CollectionData?{didSet{
        self.updateCollectionUI()
        }}
    
    func updateCollectionUI() {
        lblTitle?.text = ¿data?.title
        lblDetail?.text = ¿data?.bodyHtml
        let option = Option()
        guard let imageUrl = URL(string:data?.image?.src ?? "") else {
            return
        }
        img?.setImage(url: imageUrl, placeholder: nil, option: option) { (response) in
        }
    }
    
    
    var product : Product?{didSet{
        self.updateProductUI()
        }}
    
    func updateProductUI() {
        lblTitle?.text = ¿product?.title
        lblDetail?.text = "Total Available Inventory - " + String(product?.variants?.reduce(0,{$0 + ($1.quantity ?? 0)}) ?? 0)
        let option = Option()
        guard let imageUrl = URL(string:product?.image?.src ?? "") else {
            return
        }
        img?.setImage(url: imageUrl, placeholder: nil, option: option) { (response) in
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
