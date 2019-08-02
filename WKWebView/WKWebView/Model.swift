//
//  Model.swift
//  SwiftEXAIDDemo
//
//  Created by 高鑫 on 2017/11/9.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import Foundation
import UIKit

struct exaid {
    var name: String
    var img: String
    var detail: String
    var url: String
}

class Model {
    static let exaidInfo = [
        exaid(name: "假面骑士ExAid", img: "1", detail: """
        原文：仮面ライダーエグゼイド/Kamen Rider Ex-Aid\n
        变身者：宝生永梦、帕拉德
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABEx-Aid/19740566"),
        exaid(name: "假面骑士Brave", img: "2", detail: """
        原文：仮面ライダーブレイブ/Kamen Rider Brave\n
        变身者：镜飞彩
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABBrave"),
        exaid(name: "假面骑士Snipe", img: "3", detail: """
        原文：仮面ライダースナイプ/Kamen Rider Snipe\n
        变身者：花家大我
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABSnipe"),
        exaid(name: "假面骑士Lazer", img: "4", detail: """
        原文：仮面ライダーレーザー/Kamen Rider Lazer\n
        变身者：九条贵利矢
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABLazer"),
        exaid(name: "假面骑士Genm", img: "5", detail: """
        原文：仮面ライダーゲンム/Kamen Rider Genm\n
        变身者：檀黎斗
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABGenm"),
        exaid(name: "假面骑士Para-DX", img: "6", detail: """
        原文：仮面ライダーパラドクス/Kamen Rider Para-DX\n
        变身者：帕拉德
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABPara-DX"),
        exaid(name: "假面骑士Poppy", img: "7", detail: """
        原文：仮面ライダーポッピー/Kamen Rider Poppy\n
        变身者：Poppy Pipopapo（假野明日那）
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABPoppy"),
        exaid(name: "假面骑士Cronus", img: "8", detail: """
        原文：仮面ライダークロノス/Kamen Rider Cronus\n
        变身者：檀正宗
        """, url: "https://baike.baidu.com/item/%E5%81%87%E9%9D%A2%E9%AA%91%E5%A3%ABCronus")
    ]
}
