//
//  ToDo.swift
//  ToDoList
//
//  Created by Daryl Zandvliet on 27/11/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import Foundation


struct ToDo: Codable {
    var title : String
    var isComplete : Bool
    var dueDate : Date
    var notes : String?
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // save user changes to the directory
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    
    // define the document directory
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL)
            else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "First task ..", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "Second task ..", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "Third task ..", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    // save the todos to the document directory
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
  
    
    
}




