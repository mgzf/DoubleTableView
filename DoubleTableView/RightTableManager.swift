//
//  RightTableManager.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import UIKit
import ActionStageSwift

class RightTableManager: NSObject,LHWWatcher {

    weak  var tableView:UITableView!
    var dataSource = [RightSection]()
     var actionHandler: LHWHandler?
    
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
        if path == MGGetIndexPath, nil == arguments {
            // TODO: Load data
            LHWDispatchOnMainThread { [unowned self] in
                if let indexpath = resource as? IndexPath{
                   self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: indexpath.row), at:.top, animated: true)
                }
            }
        } else if path == MGLoadDataPath, nil == arguments {
            LHWDispatchOnMainThread { [unowned self] in
                if let data = resource as? [RightSection] {
                    self.dataSource = data
                }
                self.tableView.reloadData()
                
            }
        }
    }
}

extension RightTableManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDecelerating {
            if let selectIndexPath = tableView.indexPathsForVisibleRows?.first{
              ActionStageInstance.dispatchResource(path: MGGetIndexPath, resource: selectIndexPath, arguments: "")
            }
        }
    }
    
    
}

extension RightTableManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].content.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return dataSource[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = dataSource[indexPath.section].content[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = "\(cellData.title)"
        return cell
    }
    
}
