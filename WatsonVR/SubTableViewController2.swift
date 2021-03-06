//
//  SubTableViewController2.swift
//  WatsonVR
//
//  Created by user on 2017/11/14.
//  Copyright © 2017年 Yasuyuki Someya. All rights reserved.
//

import UIKit

class SubTableViewController2: UITableViewController {
    
    // 解析結果はAppDelegateの変数に入っている
    private let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    /**
     セルの数を返す
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.analyzedFood.count
    }
    
    /**
     データ用セルの項目をセット
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
            
        //case 0:
        //    let cell = tableView.dequeueReusableCellWithIdentifier("TVCCellA") as TVCCellA
        //    cell.cellATextLabel.text = "CustomCellA"
        //    return cell
            
        case 0:
            let image = self.appDelegate.imageFood
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultImage", for: indexPath) as! ResultImageViewCell
            //let imageData:UIImage = UIImage(named:"swift")!
            cell.setImage(image: image!)
            return cell
            
        default:
            let result = self.appDelegate.analyzedFood[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell2", for: indexPath) as! ResultTableViewCell2
            cell.setData(data: result)
            return cell
            
        }
        
    }
    
}
