//
//  ExpenseListView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/17/24.
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var manager: FinancialDataManager
    @State private var showingAddExpenseView = false
    
    var body: some View {
        VStack{
            List {
                ForEach(manager.ExpenseDetails) { Expense in
                    NavigationLink(destination: ExpenseDetailsView(manager: manager, Expenseid : Expense.id))
                    {
                        HStack{
                            Text(Expense.Name)
                            Spacer()
                            Text("$\(Expense.Amount, specifier: "%.2f)")")
                        }
                    }
                }
                .onDelete(perform: deleteExpenseSource)
                
                
                Text("Total Expense : $\(manager.TotalExpenses, specifier: "%.f)")")
                    .font(.title)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                Button("Add New Expense Source") {
                    showingAddExpenseView = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Expenses")
            .toolbar {
                EditButton()
                
            }
            .sheet(isPresented : $showingAddExpenseView) {
                AddExpenseView(manager: manager) {
                    showingAddExpenseView = false
                }
            }
        }
    }
    func deleteExpenseSource(at offsets: IndexSet) {
        manager.ExpenseDetails.remove(atOffsets: offsets)
    }
}
struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        let samplemanager = FinancialDataManager()
      ExpenseListView(manager: samplemanager)
    }
}
