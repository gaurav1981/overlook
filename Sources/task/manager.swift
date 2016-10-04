//
//  task.swift
//  overlook
//
//  Created by Wesley Cope on 9/30/16.
//
//

import Foundation
import PathKit 

public class TaskManager {
  private let defaultPath   = "/usr/bin/env"
  private var tasks:[Task]  = []

  public init() {}
  
  public func add(_ task:Task) {
    var current = tasks.filter { $0 != task }
    current.append(task)
    
    tasks = current
  }
  
  public func create(_ arguments:[String], callback: @escaping TaskHandler) -> Task {
    let queue = DispatchQueue(label: "com.overlook.queue." + arguments.joined(separator: "_"))
    let task  = Task(arguments: arguments, queue: queue, path: defaultPath, callback: callback)
  
    add(task)
    
    return task
  }
  
  public func start(task:Task) {
    let filtered = tasks.filter { $0 == task }
    
    for task in filtered {
      task.start()
    }
  }
  
  public func start() {
    for task in tasks {
      task.start()
    }
  }

  public func restart() {
    let current = tasks
    
    for task in current {
      task.stop()
    }
    
    tasks.removeAll()
    
    tasks = current.map { $0.copy() as! Task }
    
    start()
  }

  
  public func stop(task:Task) {
    let filtered = tasks.filter { $0 == task }
    
    for task in filtered {
      task.stop()
    }
  }
  
  public func remove(task:Task) {
    var current       = tasks
    let filtered      = current.filter { $0 == task }
    
    for (index, task) in filtered.enumerated() {
      task.stop()
      
      current.remove(at: index)
    }
    
    tasks = current
  }
}
