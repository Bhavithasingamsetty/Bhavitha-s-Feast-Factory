//
//  UtilitiesView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//
//
import SwiftUI


struct UtilitiesView: View {                                                                                                   // Define a view to manage and display utility-related functionalities of the financial data.
    
    @ObservedObject var financialManager: FinancialDataManager                                                                 // Use ObservedObject to observe changes in the financial manager data model.

    var body: some View {
            VStack {                                                                                                               // Display Profit/Loss status with corresponding color and percentage.
           
            HStack {
                Text(financialManager.isProfit ? "Profit" : (financialManager.isBreakEven ? "Break Even" : "Loss"))
                    .foregroundColor(financialManager.isProfit ? .green : (financialManager.isBreakEven ? .blue : .red))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.trailing, 4)

           
                Text(String(format: "%.2f%%", financialManager.CalculateProfitLossPercent()))                                   // Display the profit or loss percentage.
                    .foregroundColor(financialManager.isProfit ? .green : (financialManager.isBreakEven ? .blue : .red))
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            
            List {
                NavigationLink(destination: IncomeListView(manager: financialManager)) {                                       // Navigation link to the Income List View.
                    Text("View and Modify Income")
                        .background(Color.orange)
                        .foregroundColor(.white)
                }
            }
            
            
            List {
                NavigationLink(destination: ExpenseListView(manager: financialManager)) {                                     // Navigation link to the Expense List View.
                    Text("View and Modify Expense")
                        .background(Color.orange)
                        .foregroundColor(.white)
                }
            }
            
            
            
            AsyncImage(url: URL(string: "https://github.com/Bhavithasingamsetty/Bhavitha-s-Feast-Factory/blob/main/Pizza.png?raw=true")) { phase in                // Section to load and display image asynchronously from URLs.
                switch phase {                                                                                                                             // Image of naan from an online source.
                case .empty:                                                                                                                               // Show a progress indicator while the image is loading.
                    ProgressView()
                case .success(let image):                                                                                                                  // Display the image when successfully loaded.
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                case .failure:                                                                                                                              // Show a default image if the image fails to load.
                    Image(systemName: "photo")
                @unknown default:                                                                                                                           // Provide an empty view for future cases.
                    EmptyView()
                }
            }
            
                                                                                                                                                                 // Load a second image from a GitHub repository.
            AsyncImage(url: URL(string: "https://github.com/Bhavithasingamsetty/Bhavitha-s-Feast-Factory/blob/main/Matcha.png?raw=true")) { phase in
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
            }
            
                                                                                                                                                             // Display a local image using its name in the project assets.
            Image("Chickencurry")                                                                                                                                // Replace with your local image name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
        }
        .navigationTitle("Utilities")                                                                                                               // Set the title for the navigation bar.
        .background(
            // Use Image("YourBackgroundImageName") for a specific image or Color for a solid color.
           Image("Cake")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.2)                                                                                    // Adjust the opacity to make the background image appear dull.
                .edgesIgnoringSafeArea(.all)                                                                                                                        // Ensure the background extends to the screen edges.
)
    }
}

                                                                                                                                                            // Preview provider to render a preview of the UtilitiesView in the Xcode canvas.
struct UtilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let financialManager = FinancialDataManager()                                                                                                        // Create an instance of the FinancialDataManager.
        UtilitiesView(financialManager: financialManager)                                                                                                   // Inject the financial manager instance into the UtilitiesView.
    }
}
