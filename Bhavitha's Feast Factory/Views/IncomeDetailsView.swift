//
//  IncomeDetailsView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//
import SwiftUI

                                                                                                                                    
struct IncomeDetailsView: View {                                                                                 // View for editing the details of a particular income source.
    
    @ObservedObject var manager: FinancialDataManager                                                          // Use ObservedObject to listen for changes in the FinancialDataManager.
    
    
    var incomeSourceIndex: Int                                                                                // Index of the income source in the manager's IncomeDetails array.
    
    
    
    @State private var Name: String                                                                           // State variables to hold the name, amount, and details of the income source.
    @State private var Amount: String
    @State private var Details: String
    
    init(manager: FinancialDataManager, incomeSourceIndex: Int){                                              // The initializer configures the view with the FinancialDataManager and the index of the income source to edit.
        self.manager = manager                                                                                // It also initializes the state variables with the corresponding values from the income source.
        self.incomeSourceIndex = incomeSourceIndex
        _Name = State(initialValue: manager.IncomeDetails[incomeSourceIndex].Name)
        _Amount = State(initialValue: "\(manager.IncomeDetails[incomeSourceIndex].Amount)")
        _Details = State(initialValue: manager.IncomeDetails[incomeSourceIndex].Details)
    }
    
    var body: some View {
        
        Form {                                                                                                 // Use a form for user input, which provides a natural grouping of fields.
            
            TextField("Name", text: $Name)
            
            
            
            TextField("Amount", text: $Amount)                                                                  // Text field for editing the amount of the income source.
                .keyboardType(.numberPad)                                                                        // The keyboard is set to numberPad to facilitate numeric input.
            
            
            TextField("Details", text: $Details)                                                                   
            
            
            
            Button("Save the Changes") {                                                                         // Button to save changes made to the income source.
                if let editedAmount = Double(Amount) {                                                           // It checks for a valid double in the Amount field before saving.
                    manager.modifyIncomeDetail(index: incomeSourceIndex, newName: Name, newAmount: editedAmount, newDetails: Details)
                }
            }
            
            .frame(maxWidth: .infinity)                                                                             // Expand the button to fill the available width.
        }
        
        .navigationTitle("Edit Income Source")                                                                       // Set the title of the navigation bar to indicate editing mode.
    }
}


struct IncomeDetailsView_Previews: PreviewProvider {                                                                 // Set the title of the navigation bar to indicate editing mode.
    static var previews: some View {
        
        let manager = FinancialDataManager()                                                                         // Create an instance of the FinancialDataManager for the preview.
       
        IncomeDetailsView(manager: manager, incomeSourceIndex: 0)                                                     // Inject the manager into the IncomeDetailsView and specify the income source to edit for the preview.
    }
}
