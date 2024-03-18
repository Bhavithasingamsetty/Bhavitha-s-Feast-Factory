//
//  AddIncomeView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import SwiftUI

// Define a SwiftUI view for adding a new income source.
struct AddIncomeView: View {
    // Use ObservedObject to observe changes in the FinancialDataManager.
    @ObservedObject var manager: FinancialDataManager
    
    // Closure to be called when this view should be dismissed.
    var onDismiss: () -> Void
    
    // State variables to hold the input from the user for a new income source.
    @State private var Name = ""
    @State private var Amount = ""
    @State private var Details = ""

    var body: some View {
        // Use a NavigationView for hierarchical navigation.
        NavigationView {
            // Use a Form for user input, providing a natural grouping of fields.
            Form {
                // TextField for entering the name of the income source.
                TextField("Name", text: $Name)
                // TextField for entering the amount. The keyboard is set to decimalPad to facilitate numeric input.
                TextField("Amount", text: $Amount)
                    .keyboardType(.decimalPad)
                // TextField for entering additional details about the income source.
                TextField("Details", text: $Details)
                
                // Button to add the new income source. It validates the Amount input before adding.
                Button("Add") {
                    if let amountDouble = Double(Amount) { // Attempt to convert the Amount string to a Double.
                        manager.addIncomeDetail(Name: Name, Amount: amountDouble, Details: Details) // Add the income source.
                        onDismiss() // Call the dismissal closure to close this view.
                    }
                }
                .frame(maxWidth: .infinity) // Ensure the button expands to fill the available width.
            }
            .navigationTitle("New Income Source") // Set the title for the navigation bar.
            .toolbar {
                // Define a toolbar item for cancellation, positioned appropriately.
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onDismiss() // Call the dismissal closure to close this view without adding a new income source.
                    }
                }
            }
        }
    }
}

// Preview provider for AddIncomeView.
struct AddIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of FinancialDataManager for the preview.
        let manager = FinancialDataManager()
        // Render the AddIncomeView in the preview, passing the manager instance and an empty closure for onDismiss.
        AddIncomeView(manager: manager, onDismiss: {})
    }
}
