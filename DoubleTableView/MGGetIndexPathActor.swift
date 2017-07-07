//
//  MGGetIndexPathActor.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import ActionStageSwift

class MGGetIndexPathActor: MGActor {
    override class func genericPath() -> String? {
        return MGGetIndexPath
    }
    
    override func execute(options: [String : Any]?) {
        // TODO: send indexpath
        
        ActionStageInstance.dispatchResource(path: path, resource: [:], arguments: nil)
        ActionStageInstance.actionCompleted(path)
    }
}

