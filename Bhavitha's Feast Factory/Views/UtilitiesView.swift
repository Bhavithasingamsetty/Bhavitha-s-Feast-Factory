//
//  UtilitiesView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//
//
import SwiftUI
struct UtilitiesView: View {
    @ObservedObject var financialManager: FinancialDataManager
    var body: some View {
        VStack {
            HStack {
                Text(financialManager.isProfit ? "Profit" : (financialManager.isBreakEven ? "Break Even:" : "Loss:"))
                    .foregroundColor(financialManager.isProfit ? .green : (financialManager.isBreakEven ? .blue : .red))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.trailing, 4)
                
                
                Text(String(format:"%2f%%", financialManager.CalculateProfitLossPercent()))
                    .foregroundColor(financialManager.isProfit ? .green : (financialManager.isBreakEven ? .blue : .red))
                    .font(.title)
                    .fontWeight(.bold)
            }
            List {
                NavigationLink(destination: IncomeListView(manager: financialManager)) {
                    Text("View and Modify Income")
                }
            }
                
                // Asynchronously Loaded Images
                AsyncImage(url: URL(string: "https://www.pexels.com/photo/baked-pizza-on-pizza-peel-in-oven-905847/")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                    .aspectRatio(contentMode:.fill)
                    .frame(width: 150,height:150)
                    .cornerRadius(10)
                        
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                
            List {
                NavigationLink(destination: ExpenseListView(manager: financialManager)) {
                    Text("View and Modify Expense")
                }
            }
                        
                        AsyncImage(url: URL(string: "https://www.flaticon.com/free-icon/income_10691770")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                            
                            // Local Image Example
                            Image("Image2nd") // Replace with your local image name
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode:.fill)
                                .frame(width: 150, height: 150)
                        }
                        .navigationTitle("Utilities")
        }
    }
}
            struct UtilitiesView_Previews: PreviewProvider {
                static var previews: some View {
                    let financialManager = FinancialDataManager()
                    UtilitiesView(financialManager: financialManager)
                }
}
