//
//  MGCustomTableView.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import UIKit
import ActionStageSwift
class MGCustomTableView: UITableView {
    func tt() {
        ActionStageInstance.dispatchMessageToWatchers(path: MGGetIndexPath, messageType: nil, message: nil)
    }
}
