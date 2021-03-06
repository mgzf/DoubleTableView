//
//  LHWTimer.swift
//  ActionStageSwift
//
//  Created by Hanguang on 2017/3/7.
//  Copyright © 2017年 Hanguang. All rights reserved.
//
// Copyright (c) 2017年 Hanguang
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public final class LHWTimer {
    
    // MARK: -
    
    public var timeoutDate: TimeInterval = Double(INTMAX_MAX)
    
    fileprivate var timer: DispatchSourceTimer?
    fileprivate var timeout: TimeInterval
    fileprivate var shouldRepeat = false
    fileprivate var completion: (() -> Void)?
    fileprivate var queue: DispatchQueue
    
    public init(timeout: TimeInterval, shouldRepeat: Bool, completion: @escaping () -> Void, queue: DispatchQueue) {
        self.timeout = timeout
        self.shouldRepeat = shouldRepeat
        self.completion = completion
        self.queue = queue
    }
    
    deinit {
        if timer != nil {
            timer?.cancel()
            timer = nil
        }
    }
    
    // MARK: -
    
    public func start() {
        timeoutDate = CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970 + timeout
        
        timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: queue)
        if shouldRepeat {
            timer?.scheduleRepeating(deadline: .now() + timeout, interval: timeout)
        } else {
            timer?.scheduleOneshot(deadline: .now() + timeout)
        }
        
        timer?.setEventHandler(handler: { [weak self] in
            guard let `self` = self else { return }
            
            if let completion = self.completion {
                completion()
            }
            
            if !self.shouldRepeat {
                self.invalidate()
            }
        })
        
        timer?.resume()
    }
    
    public func fireAndInvalidate() {
        if let completion = completion {
            completion()
        }
        invalidate()
    }
    
    public func invalidate() {
        timeoutDate = 0
        if timer != nil {
            timer?.cancel()
            timer = nil
        }
    }
    
    public func isScheduled() -> Bool {
        return timer != nil
    }
    
    public func resetTimeout(timeout: TimeInterval) {
        invalidate()
        self.timeout = timeout
        start()
    }
    
    public func remainingTime() -> TimeInterval {
        if timeoutDate < Double(Float.ulpOfOne) {
            return Double.greatestFiniteMagnitude
        } else {
            return timeoutDate - (CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970)
        }
    }
}
