//
//  ContentView.swift
//  Todos
//
//  Created by Aidan Pendlebury on 12/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var description: String
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var showingAddTodoView = false
    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 5) {
                    ForEach(todos) { item in
                        HStack {
                            Text(item.description).padding()
                            Spacer()
                            Button("Delete") { self.delete(item: item) }.foregroundColor(.white).padding().background(Color.gray)
                        }.background(Color(UIColor.lightGray))
                    }
                    Spacer()
                }
                .navigationBarTitle(Text("Todos"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { self.showingAddTodoView = true }) {
                    Image(systemName: "plus")
                })
            }
            if showingAddTodoView {
                ZStack {
                    Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                    AddItemView(todos: self.$todos, showingTodoView: $showingAddTodoView)
                }
            }
        }
    }
    
    func delete(item: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == item.id }) {
            withAnimation { todos.remove(at: index) }
        }
    }
    
}

struct AddItemView: View {
    @Binding var todos: [TodoItem]
    @Binding var showingTodoView: Bool
    @State private var newItem = ""
    var body: some View {
        ZStack {
            Color.white.shadow(radius: 10, x: 5, y: 5)
            VStack(alignment: .leading) {
                Text("Add item").font(.body).fontWeight(.bold).padding()
                Spacer()
                TextField("", text: $newItem).background(Color.gray).padding(.horizontal)
                Spacer()
                HStack {
                    Spacer()
                    Button("OK") { self.saveNewItem() }.foregroundColor(.black).padding()
                }
            }
        }
        .frame(width: 260, height: 150)
    }
    
    func saveNewItem() {
        guard !newItem.isEmpty else { return }
        withAnimation { self.todos.append(TodoItem(description: newItem)) }
        self.showingTodoView = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
