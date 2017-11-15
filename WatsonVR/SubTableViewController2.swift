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
     セルの項目をセット
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = self.appDelegate.analyzedFood[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell2", for: indexPath) as! ResultTableViewCell2
        cell.setData(data: result)
        return cell
    }
}
