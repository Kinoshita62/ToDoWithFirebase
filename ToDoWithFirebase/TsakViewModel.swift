//
//  TsakViewModel.swift
//  ToDoWithFirebase
//
//  Created by USER on 2024/09/25.
//

import Foundation
import FirebaseFirestore

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var db = Firestore.firestore()

    // Firestoreからタスクを取得
    func fetchTasks() {
        db.collection("tasks").order(by: "isCompleted").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching tasks: \(error.localizedDescription)")
                return
            }
            self.tasks = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Task.self)
            } ?? []
        }
    }

    // 新しいタスクをFirestoreに追加
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        do {
            _ = try db.collection("tasks").addDocument(from: newTask)
        } catch {
            print("Error adding task: \(error.localizedDescription)")
        }
    }

    // タスクを削除
    func deleteTask(taskID: String) {
        db.collection("tasks").document(taskID).delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}

