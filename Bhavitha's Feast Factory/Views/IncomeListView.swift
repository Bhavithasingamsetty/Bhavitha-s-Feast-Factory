//
//  IncomelistView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import SwiftUI

struct IncomeListView: View {
    @ObservedObject var manager: FinancialDataManager
    @State private var showingAddIncomeView = false

    var body: some View {
        VStack{
            
            List {
                ForEach(manager.IncomeDetails.indices, id: \.self) {
                    index in
                    NavigationLink(destination: IncomeDetailsView(manager: manager, incomeSourceIndex: index))
                    {
                        HStack{
                            Text(manager.IncomeDetails[index].Name)
                            Spacer()
                            Text("\(manager.IncomeDetails[index].Name): $\(manager.IncomeDetails[index].Amount, specifier: "%.2f")")
                        }
                    }
                }
                .onDelete(perform: deleteIncomeSource)
                Text("Total Income: $\(manager.TotalIncome, specifier: "%.2f")")
                    .font(.title2)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                Button("Add New  Income Sources")
                {
                    showingAddIncomeView = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Income Sources")
        .toolbar {
            EditButton()
        }
        .sheet(isPresented: $showingAddIncomeView) {
            AddIncomeView(manager: manager){
                showingAddIncomeView = false
            }
        }
    }

    func deleteIncomeSource(at offsets: IndexSet) {
        manager.IncomeDetails.remove(atOffsets: offsets)
    }
}
struct IncomeListView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = FinancialDataManager()
        IncomeListView(manager: manager)
    }
}
