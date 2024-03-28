//
//  ContentView.swift
//  App
//
//  Created by Abdul Kadir Öci on 09.02.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var newItemName = "" // State variable to store the input text
    @State var viewModel = ViewModel()
    
    var body: some View {
           NavigationStack {
               VStack {
                   List(viewModel.items) { item in
                       NavigationLink("Go to user \(item.name)", destination: DetailView(item: item))
                       .contextMenu {
                           Button("Delete") {
                               viewModel.deleteItem(item)
                           }
                       }
                   }
                   
                   Divider() // Add a divider between list and input fields
                   
                   // Textfield and button to add new items
                   HStack {
                       TextField("Enter name", text: $newItemName)
                       Button("Add") {
                           viewModel.createItem(name: newItemName)
                           newItemName = ""
                       }
                   }
                   .padding()
                   Button("Delete All Users") {
                       viewModel.deleteAllItems()
                   }.foregroundColor(.red)
                                   .padding()
               }
               .navigationTitle("User")
               .onAppear {
                   viewModel.modelContext = modelContext
                   viewModel.fetchItems()
               }
           }
       }
}

struct DetailView : View {
    let item : Item
    var body: some View {
        VStack{
            Text("This is user \(item.name)")
        }.navigationTitle("Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
