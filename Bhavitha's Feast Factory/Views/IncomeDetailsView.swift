//
//  IncomeDetailsView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//
import SwiftUI



struct IncomeDetailsView: View {
    @ObservedObject var manager: FinancialDataManager
    var incomeSourceIndex: Int
    @State private var Name: String
    @State private var Amount: String
    @State private var Details: String
    init(manager: FinancialDataManager,incomeSourceIndex:Int){
        self.manager = manager
        self.incomeSourceIndex = incomeSourceIndex
        _Name = State(initialValue: manager.IncomeDetails[incomeSourceIndex].Name)
        _Amount = State(initialValue: "\(manager.IncomeDetails[incomeSourceIndex].Amount)")
        _Details = State(initialValue: manager.IncomeDetails[incomeSourceIndex].Details)
    }
    var body: some View{
        Form{
            TextField("Name", text: $Name)
            TextField("Amount", text: $Amount)
                .keyboardType(.numberPad)
            TextField("Details", text: $Details)
            
            Button("Save the Changes") {
                if let editedAmount = Double(Amount) {
                    manager.modifyIncomeDetail(index: incomeSourceIndex, newName: Name, newAmount: editedAmount, newDetails: Details)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Edit Income Source")
    }
}
struct IncomeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = FinancialDataManager()
        IncomeDetailsView(manager: manager, incomeSourceIndex: 0)
    }
}
    
  

