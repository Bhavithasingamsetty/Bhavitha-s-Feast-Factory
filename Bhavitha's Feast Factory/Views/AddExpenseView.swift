//
//  AddExpenseView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI

// Defines a view for adding a new expense to the financial manager.
struct AddExpenseView: View {
    // Observes changes in FinancialDataManager to reactively update the view.
    @ObservedObject var manager : FinancialDataManager
    
    // A closure that will be called to dismiss this view.
    var onDismiss: () -> Void
    
    // State variables for the input fields in the form.
    @State private var Name = ""
    @State private var Amount = ""
    @State private var Details = ""
    
    var body: some View {
        // Wraps the form in a navigation view for hierarchical structuring.
        NavigationView {
            Form {
                // Input field for the expense name.
                TextField("Name", text: $Name)
                
                // Input field for the expense amount. The keyboard is set to decimalPad for numeric input.
                TextField("Amount", text: $Amount)
                    .keyboardType(.decimalPad)
                
                // Input field for additional details of the expense.
                TextField("Details", text: $Details)
                
                // Button to add the expense to the financial manager's data.
                Button("Add") {
                    // Attempts to convert the amount string to a Double and adds the expense.
                    if let amountDouble = Double(Amount) {
                        manager.addExpenseDetail(Name: Name, Amount: amountDouble, Details: Details)
                        onDismiss() // Calls the onDismiss closure to dismiss the view after adding the expense.
                    }
                }
                .frame(maxWidth: .infinity) // Ensures the button expands to fill the available width.
            }
            .navigationTitle("Add Expense") // Sets the navigation bar title for this view.
            .toolbar {
                // Adds a toolbar with a cancel button to dismiss the view without adding an expense.
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onDismiss() // Invokes the onDismiss closure to dismiss this view.
                    }
                }
            }
        }
    }
}

// Preview provider for AddExpenseView.
struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        // Creates an instance of FinancialDataManager for the preview.
        let manager = FinancialDataManager()
        // Renders the AddExpenseView with the manager instance and an empty onDismiss closure for previews.
        AddExpenseView(manager: manager, onDismiss: {})
    }
}
