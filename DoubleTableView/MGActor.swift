//
//  MGActor.swift
//  DoubleTableView
//
//  Created by Winann on 06/07/2017.
//  Copyright © 2017 Winann. All rights reserved.
//

import ActionStageSwift

class MGActor: LHWActor {
    class MGActor: LHWActor {
        
        override func cancel() {
            if cancelToken != nil {
                // TODO: cancel
                cancelToken = nil
            }
            
            if multipleCancelTokens.count > 0 {
                for _ in multipleCancelTokens {
                    // TODO: cancel
                }
                
                multipleCancelTokens.removeAll()
            }
            
            super.cancel()
        }
        
        deinit {
            Logger.debug("Actor deinit path: \(self.path)")
        }
    }
}
