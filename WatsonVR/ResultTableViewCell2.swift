//
//  ResultTableViewCell2.swift
//  WatsonVR
//
//  Created by user on 2017/11/15.
//  Copyright © 2017年 Yasuyuki Someya. All rights reserved.
//

import UIKit

class ResultTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classScoreLabel: UILabel!
    /**
     セルの内容をセット
     - parameter data: 解析結果
     */
    func setData(data: AnalyzedFood) {
        //self.foodImageView.image = data.imageFood
        if let foodClass = data.foodClass {
            self.classNameLabel.text = "クラス：" + foodClass
        }
        if let foodScore = data.foodScore {
            self.classScoreLabel.text = "確信度：" + foodScore + "%"
        }
    }
}

