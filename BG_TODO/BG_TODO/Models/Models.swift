//
//  ToDoItem.swift
//  BG_TODO
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

protocol ToDo {
    var name: String {get set}
    var isComplete: Bool { get set}
    var subtasks: [ToDo] { get set }
}

final class ToDoItemWithCheckList: ToDo {

    var name: String

    var isComplete: Bool

    var subtasks: [ToDo]

    public init(name: String,
              subtasks: [ToDo]) {

        self.name = name
        self.isComplete = false
        self.subtasks = subtasks
    }

}

import Foundation

final class ToDoItem: ToDo {
    // MARK: - Properties
    var name: String
    var isComplete: Bool
    var subtasks: [ToDo]


    // MARK: - Initializers
    init(name: String) {
        self.name = name
        isComplete = false
        subtasks = []
    }
}
