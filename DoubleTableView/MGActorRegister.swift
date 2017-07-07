//
//  MGActorRegister.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import ActionStageSwift

struct MGActorRegister {
    static func register() {
        LHWActor.registerActorClass(MGLoadDataActor.self)
        LHWActor.registerActorClass(MGGetIndexPathActor.self)
    }
}

// MARK: - 

let MGLoadDataPath = "loadData"
let MGGetIndexPath = "getIndexPath"




