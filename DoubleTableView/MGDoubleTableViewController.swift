//
//  MGDoubleTableViewController.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import UIKit
import ActionStageSwift
class MGDoubleTableViewController: MGBaseViewController, LHWWatcher {
    
    @IBOutlet weak var leftTableView: UITableView!
//    fileprivate var leftTableView: MGCus
    @IBOutlet weak var rightTableView: UITableView!

    var leftMgr: LeftTableManager!
    var rightMgr: RightTableManager!
    
    // MARK: - LHWWatcher
    
    var actionHandler: LHWHandler?
    
    // MARK: - 生命周期
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }
    override func viewDidLoad() {
        
        
        
        actionHandler = LHWHandler(delegate: self)
        ActionStageInstance.watchForPath(MGLoadDataPath, watcher: self)
        ActionStageInstance.watchForPath(MGGetIndexPath, watcher: self)
        view.backgroundColor = UIColor.yellow
        

        
        ActionStageInstance.dispatchMessageToWatchers(path: MGGetIndexPath, messageType: "indexPath", message: nil)
        
        
        leftMgr = LeftTableManager.init(rightTable: leftTableView)
        rightMgr = RightTableManager.init(rightTable: rightTableView)
        
        ActionStageInstance.requestActor(path: MGLoadDataPath, options: nil, watcher: self)
        
    }
    
    
    // MARK: - LHWWatcher
    
    func actionStageResourceDispatched(path: String, resource: Any?, arguments: Any?) {
        if path == MGLoadDataPath {
            // TODO: Load data
            LHWDispatchOnMainThread { [unowned self] in
                
            }
        }
    }
    
    func actorMessageReceived(path: String, messageType: String?, message: Any?) {
        if path == MGGetIndexPath {
            // TODO: received "index path"
        }
    }
    
    func actionStageActionRequested(_ action: String, options: [String : Any]?) {
        if action == MGGetIndexPath {
            
        }
    }
    
    // test
    
    func test() {
        
        // send message
        ActionStageInstance.dispatchMessageToWatchers(path: MGGetIndexPath, messageType: nil, message: ["indexPath": IndexPath(row: 0, section: 0)])
    }
}
