//
//  ExpenseListView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI

// Defines a view for listing and managing expenses.
struct ExpenseListView: View {
    // Observes changes to the FinancialDataManager to update the view accordingly.
    @ObservedObject var manager: FinancialDataManager
    
    // State variable to control the presentation of the AddExpenseView.
    @State private var showingAddExpenseView = false
    
    var body: some View {
        VStack {
            // List to display each expense in the ExpenseDetails array.
            List {
                // Loop through each expense in ExpenseDetails using SwiftUI's ForEach.
                ForEach(manager.ExpenseDetails) { Expense in
                    // Navigation link to edit details of the expense. Passes the selected expense's ID to the destination.
                    NavigationLink(destination: ExpenseDetailsView(manager: manager, Expenseid: Expense.id)) {
                        HStack {
                            // Display the name of the expense.
                            Text(Expense.Name)
                            Spacer()
                            // Display the amount of the expense, formatted as currency.
                            Text("$\(Expense.Amount, specifier: "%.2f")")
                        }
                    }
                }
                // Allows deleting an expense from the list.
                .onDelete(perform: deleteExpenseSource)
                
                // Displays the total expenses calculated by the FinancialDataManager.
                Text("Total Expense: $\(manager.TotalExpenses, specifier: "%.f")")
                    .font(.title)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                // Button to show the view for adding a new expense source.
                Button("Add New Expense Source") {
                    showingAddExpenseView = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Expenses")
            .toolbar {
                // Adds an edit button to the toolbar for managing the list of expenses.
                EditButton()
            }
                                                                                                                
            // Presents a sheet to add a new expense when triggered.
            .sheet(isPresented: $showingAddExpenseView) {
                AddExpenseView(manager: manager) {
                    // Closure to hide the sheet once the action is complete.
                    showingAddExpenseView = false
                }
            }
        }
    }

    // Function to delete an expense from the ExpenseDetails array.
    func deleteExpenseSource(at offsets: IndexSet) {
        manager.ExpenseDetails.remove(atOffsets: offsets)
    }
}

// Preview provider to render a preview of the ExpenseListView in the Xcode canvas.
struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of FinancialDataManager for the preview.
        let sampleManager = FinancialDataManager()
        // Render the ExpenseListView in the preview, passing the FinancialDataManager instance.
        ExpenseListView(manager: sampleManager)
    }
}
