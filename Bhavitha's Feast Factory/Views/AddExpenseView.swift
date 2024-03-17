//
//  AddExpenseView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI
struct AddExpenseView: View {
    @ObservedObject var manager : FinancialDataManager
    var onDismiss: () -> Void
    @State private var Name = ""
    @State private var Amount = ""
    @State private var Details = ""
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $Name)
                TextField("Amount", text: $Amount)
                    .keyboardType(.decimalPad)
                TextField("Details", text: $Details)
                
                Button("Add") {
                    if let amountDouble = Double(Amount) {
                        manager.addExpenseDetail(Name: Name, Amount: amountDouble, Details: Details)
                        onDismiss()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Add Expense")
            .toolbar { // Adds a toolbar item for cancellation, invoking the onDismiss closure when tapped.
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        onDismiss() // Calls the onDismiss closure to close or refresh the view.
                    }
                }
            }
            
        }
    }
}
struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
                
        let manager = FinancialDataManager() // Instantiate the data manager
                
                AddExpenseView(manager:manager, onDismiss:
                {
                    
                }) // Pass the data manager to the view
            }
        }
