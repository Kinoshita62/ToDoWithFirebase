//
//  ContentView.swift
//  ToDoWithFirebase
//
//  Created by USER on 2024/09/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("新しいタスク", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.title3)
                        .padding()
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(title: newTaskTitle)
                            newTaskTitle = ""
                        }
                    }) {
                        Text("追加")
                            .padding()
                            .background(Color.blue)
                            .frame(height: 35)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                }

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            if task.isCompleted {
                                Text("✔️")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            if let taskID = viewModel.tasks[index].id {
                                viewModel.deleteTask(taskID: taskID)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("ToDoリスト")
            .onAppear {
                viewModel.fetchTasks()
            }
        }
    }
}

#Preview {
    ContentView()
}

