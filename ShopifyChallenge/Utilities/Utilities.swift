//
//  Utilities.swift
//
//  Created by Haspinder on 29/09/19.
//  Copyright © 2019 Haspinder Singh. All rights reserved.
//

import Foundation
import UIKit

class UtilityFunctions{

    typealias  doneComplete = (AnyObject) -> ()

   
    
    static func getDate(format : String,date : String) -> Date?{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        dateformatter.timeZone = NSTimeZone(name: "UTC") as TimeZone? ?? NSTimeZone.default
        return dateformatter.date(from: date) as Date?
    }
    
    static func getDateFormatted(format : String,date : Date) -> String?{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date as Date)
    }
    

    
    
    static func showActionSheet(vc:UIViewController,title : String?,subtitle : String?,buttons:[String],btnAction:@escaping doneComplete){
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: title, message:subtitle, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        for (index,item) in buttons.enumerated() {
            let actionButton = UIAlertAction(title: item, style: .default) { action -> Void in
                btnAction(index as AnyObject)
            }
            actionSheetController.addAction(actionButton)
        }
        vc.present(actionSheetController, animated: true, completion: nil)
    }

    
   
}
