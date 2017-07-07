//
//  LeftTableManager.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import UIKit
import ActionStageSwift

class LeftTableManager: NSObject,LHWWatcher {
    
    weak  var tableView: UITableView!
    var actionHandler: LHWHandler?
    fileprivate var dataSource = [LeftItem]()
    
    init(rightTable:UITableView) {
        super.init()
        tableView = rightTable
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    
        actionHandler = LHWHandler(delegate: self)
        ActionStageInstance.watchForPath(MGGetIndexPath, watcher: self)
        ActionStageInstance.watchForPath(MGLoadDataPath, watcher: self)
    }
    
    func actionStageResourceDispatched(path: String, resource: Any?, arguments: Any?) {
        if path == MGGetIndexPath {
            // TODO: Load dat
            guard let _ = arguments else {
                return
            }
            LHWDispatchOnMainThread { [unowned self] in
                if let indexpath = resource as? IndexPath{
                    
                    self.tableView.selectRow(at: IndexPath.init(row: indexpath.section, section: 0), animated: true, scrollPosition: .none)
                }
            }
        } else if path == MGLoadDataPath {
            LHWDispatchOnMainThread { [unowned self] in
                if let data = resource as? [LeftItem] {
                    self.dataSource = data
                }
                self.tableView.reloadData()
                
            }
        }
    }
}

extension LeftTableManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      ActionStageInstance.dispatchResource(path: MGGetIndexPath, resource: indexPath, arguments: nil)
    }
    
    
    
}

extension LeftTableManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = "\(cellData.title)"
        return cell
    }
    
}
