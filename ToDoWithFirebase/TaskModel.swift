//
//  TaskModel.swift
//  ToDoWithFirebase
//
//  Created by USER on 2024/09/25.
//

import Foundation
import FirebaseFirestore

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isCompleted: Bool
}

