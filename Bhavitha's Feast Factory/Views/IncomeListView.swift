//
//  IncomelistView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import SwiftUI


struct IncomeListView: View {
    // Use ObservedObject to react to changes in the FinancialDataManager.
    @ObservedObject var manager: FinancialDataManager
    
    // State variable to control the display of the view for adding a new income source.
    @State private var showingAddIncomeView = false

    var body: some View {
        VStack {
            // List all income sources.
            List {
                // Iterate over each income source using their indices for identification.
                ForEach(manager.IncomeDetails.indices, id: \.self) { index in
                    // Create a navigation link to edit details of the income source.
                    NavigationLink(destination: IncomeDetailsView(manager: manager, incomeSourceIndex: index)) {
                        HStack {
                            // Display the name of the income source.
                            Text(manager.IncomeDetails[index].Name)
                            Spacer()
                            // Display the amount of the income source formatted as currency.
                            Text("$\(manager.IncomeDetails[index].Amount, specifier: "%.2f")")
                        }
                    }
                }
                // Provide functionality to delete an income source.
                .onDelete(perform: deleteIncomeSource)
                
                // Display the total income calculated by the FinancialDataManager.
                Text("Total Income: $\(manager.TotalIncome, specifier: "%.2f")")
                    .font(.title2)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                
                // Button to trigger the display of the add new income source view.
                Button("Add New Income Sources") {
                    showingAddIncomeView = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Income Sources")
        .toolbar {
            // Add an edit button to the toolbar for managing the list.
            EditButton()
        }
        // Present a sheet for adding a new income source when triggered.
        .sheet(isPresented: $showingAddIncomeView) {
            AddIncomeView(manager: manager) {
                // Closure to hide the sheet once the action is complete.
                showingAddIncomeView = false
            }
        }
    }

    // Function to delete an income source at the specified index.
    func deleteIncomeSource(at offsets: IndexSet) {
        manager.IncomeDetails.remove(atOffsets: offsets)
    }
}

// Preview provider for IncomeListView.
struct IncomeListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of FinancialDataManager for the preview.
        let manager = FinancialDataManager()
        // Render the IncomeListView in the preview, passing the FinancialDataManager instance.
        IncomeListView(manager: manager)
    }
}
