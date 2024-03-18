//
//  ExpenseDetailsView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI

// Defines a view for displaying and editing the details of a specific expense item.
struct ExpenseDetailsView: View {
    // Use ObservedObject to listen for changes in the FinancialDataManager.
    @ObservedObject var manager: FinancialDataManager
    
    // The unique identifier for the specific expense item being edited.
    var Expenseid: UUID
    
    // State variables to hold the current input values for the expense's name, amount, and details.
    // These are editable fields within the form.
    @State private var Name: String = ""
    @State private var Amount: String = ""
    @State private var Details: String = ""
    
    // Initializes the view with a specific expense item, using its unique identifier.
    init(manager: FinancialDataManager, Expenseid: UUID) {
        self.manager = manager
        self.Expenseid = Expenseid
        
        // Attempt to find the expense in the manager using the provided ExpenseId.
        // If found, initialize the state variables with the current values of the expense item.
        if let Expense = manager.ExpenseDetails.first(where: { $0.id == Expenseid }) {
            _Name = State(initialValue: Expense.Name)
            _Amount = State(initialValue: String(Expense.Amount))
            _Details = State(initialValue: Expense.Details)
        }
    }
    
    var body: some View {
        // Use a form to structure the input fields for editing expense details.
        Form {
            // TextField for editing the name of the expense.
            TextField("Name", text: $Name)
            
            // TextField for editing the amount of the expense.
            // The keyboard is set to decimalPad to facilitate numeric input.
            TextField("Amount", text: $Amount)
                .keyboardType(.decimalPad)
            
            // TextField for editing additional details of the expense.
            TextField("Details", text: $Details)
            
            // Button to save the changes made to the expense item.
            Button("Save Changes") {
                // Attempt to convert the edited amount to a Double and save the changes.
                if let editedAmount = Double(Amount) {
                    manager.modifyExpenseDetail(id: Expenseid, newName: Name, newAmount: editedAmount, newDetails: Details)
                }
            }
            .frame(maxWidth: .infinity) // Ensure the button expands to fill the available width.
        }
        .navigationTitle("Add Expense") // Set the title for the navigation bar.
    }
}

// Preview provider for ExpenseDetailsView.
struct ExpenseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of FinancialDataManager for the preview.
        let manager = FinancialDataManager()
        // Render the ExpenseDetailsView in the preview, passing a new instance of FinancialDataManager and a new UUID.
        ExpenseDetailsView(manager: manager, Expenseid: UUID())
    }
}
