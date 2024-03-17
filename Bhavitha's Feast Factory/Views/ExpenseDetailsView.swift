//
//  ExpenseDetailsView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI

struct ExpenseDetailsView: View {
    @ObservedObject var manager:FinancialDataManager
    var Expenseid: UUID
    @State private var Name: String = "" // These states hold the editable fields for the expense details.
    @State private var Amount: String = ""
    @State private var Details: String = ""
    
    init(manager: FinancialDataManager, Expenseid: UUID) {
        self.manager = manager// Initialize the state variables with the values from the specific expense being edited.
        self.Expenseid = Expenseid // Find the expense in the ExpenseManager using the provided expenseId.
        if let Expense = manager.ExpenseDetails.first(where: { $0.id == Expenseid })
        {
            _Name = State(initialValue: Expense.Name)
            _Amount = State(initialValue: String(Expense.Amount))
            _Details = State(initialValue: Expense.Details)
        }
    }
    var body: some View {
        Form {
            TextField("Name", text: $Name)
            TextField("Amount", text: $Amount)
                .keyboardType(.decimalPad)
            TextField("Details", text: $Details)
            
            Button("Save Changes") { // Attempt to save the changes made to the expense details.
                
                if let editedAmount = Double(Amount) {
                    manager.modifyExpenseDetail(id: Expenseid, newName: Name, newAmount: editedAmount, newDetails: Details)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Add Expense")
    }
}
struct ExpenseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let manager  = FinancialDataManager()
       ExpenseDetailsView(manager: FinancialDataManager(), Expenseid: UUID())
        
    }
}

