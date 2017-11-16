//
//  ResultImageViewCell.swift
//  WatsonVR
//
//  Created by user on 2017/11/15.
//  Copyright © 2017年 Yasuyuki Someya. All rights reserved.
//

import UIKit

class ResultImageViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    /**
     セルの内容をセット
     - parameter data: 解析結果
     */
    func setImage(image: UIImage) {
        self.foodImageView.image = image
    }
    
}
