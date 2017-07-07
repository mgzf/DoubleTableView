//
//  MGLoadDataActor.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import ActionStageSwift

class MGLoadDataActor: MGActor {
    
    override class func genericPath() -> String? {
        return MGLoadDataPath
    }
    
    override func execute(options: [String : Any]?) {
        // TODO: load data
        var leftList: [LeftItem] = [LeftItem]()
        var rightList: [RightSection] = [RightSection]()
        
        for i in 0...10 {
            let left = LeftItem(title: "\(i)")
            leftList.append(left)
            var rightContent: [RightItem] = [RightItem]()
            for j in 0..<5 {
                let rightItem = RightItem(title: "\(i)", subTitle: "\(j)")
                rightContent.append(rightItem)
            }
            let rightSec = RightSection(title: "\(i)", content: rightContent)
            rightList.append(rightSec)
        }

        
        
        ActionStageInstance.dispatchResource(path: path, resource: leftList, arguments: "")
        ActionStageInstance.dispatchResource(path: path, resource: rightList, arguments: nil)
        
        ActionStageInstance.actionCompleted(path)
    }
}
