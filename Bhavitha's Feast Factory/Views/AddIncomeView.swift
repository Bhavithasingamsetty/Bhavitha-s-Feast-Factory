//
//  AddIncomeView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import SwiftUI

struct AddIncomeView: View {
    @ObservedObject var manager: FinancialDataManager
    var onDismiss: () -> Void
    @State private var Name = ""
    @State private var Amount = ""
    @State private var Details = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $Name)
                TextField("Amount", text: $Amount)
                    .keyboardType(.decimalPad)
                TextField("Details", text: $Details)
                
                Button("Add") {
                    if let amountDouble = Double(Amount) {
                        manager.addIncomeDetail(Name: Name, Amount: amountDouble, Details: Details)
                        onDismiss()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("New Income Source")
            .toolbar{
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cancel")
                    {
                        onDismiss()
                    }
                }
            }
        }
    }
}
struct AddIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = FinancialDataManager()
    AddIncomeView(manager: manager ,onDismiss:
    {
        
    })
}
}


