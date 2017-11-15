//
//  OriginalTabBarController.swift
//  WatsonVR
//
//  Created by user on 2017/11/13.
//  Copyright © 2017年 Yasuyuki Someya. All rights reserved.
//

import UIKit
//タブバー設定
class OriginalTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fontの設定
        let fontFamily: UIFont! = UIFont.systemFont(ofSize: 10)
        
        // 選択時の設定
        let selectedColor:UIColor = UIColor(red: 65.0/255.0, green: 168.0/255.0, blue: 186.0/255.0, alpha: 1)
        let selectedAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: selectedColor] as [String : Any]
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: UIControlState.selected)
        /// アイコンカラーの設定
        UITabBar.appearance().tintColor = selectedColor
        
        
        // 非選択時の設定
        let nomalAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: UIColor.gray] as [String : Any]
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(nomalAttributes, for: UIControlState.normal)
        /// アイコンカラー（画像）の設定
        var assets :Array<String> = ["TabBarListImage.jpg", "TabBarSearchImage.jpg", "TabBarAccountImage.jpg"]
        for (idx, item) in self.tabBar.items!.enumerated() {
            item.image = UIImage(named: assets[idx])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
}
