//
//  ViewModel.swift
//  App
//
//  Created by Abdul Kadir Öci on 23.02.24.
//

import Foundation
import SwiftData

@Observable
class ViewModel {
    var modelContext: ModelContext?=nil
    var items : [Item]=[]
    
    func createItem(name: String) {
         let newItem = Item(name: name)
         modelContext?.insert(newItem)
         try? modelContext?.save()
         fetchItems()
    }

     func fetchItems() {
         let fetchDescriptor = FetchDescriptor<Item>(
            sortBy: [SortDescriptor(\.name)])
         if let context = modelContext {
             do {
                 items = try context.fetch(fetchDescriptor)
             } catch {
                 items = []
             }
         } else {
             items = []
         }
    }
    
    func deleteItem(_ item: Item) {
        guard let context = modelContext else {
            return // Exit function if modelContext is nil
        }
        
        do {
            context.delete(item)
            try context.save()
            if let index = items.firstIndex(of: item) {
                items.remove(at: index) // Remove the item from the items array
            }
        } catch {
            print("Error deleting one item: \(error)")
        }
    }
    
    func deleteAllItems() {
            items.forEach { item in
                modelContext?.delete(item)
            }
            try? modelContext?.save()
            items.removeAll()
        }
}
