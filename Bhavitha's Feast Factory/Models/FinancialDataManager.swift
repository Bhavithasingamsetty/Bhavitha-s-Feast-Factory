//
//  FinancialManager.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import Combine
import Foundation

class FinancialDataManager: ObservableObject {              // Manages financial data related to income and expenses for a business.
    struct IncomeDetail {                                   // Represents a single income source.
        let Name: String
        let Amount: Double
        let Details: String
    }
    struct ExpenseDetail : Identifiable{                    // Represents a single expense item, identifiable by a unique ID
        let id : UUID = UUID()
        var Name: String
        var Amount: Double
        var Details: String
    }
    
    @Published var IncomeDetails: [IncomeDetail] = []               // Collection of all income details, observed for UI updates.
    //@Published var TotalExpenses: Double = 0
    @Published var ExpenseDetails: [ExpenseDetail] = []             // Collection of all expense details, observed for UI updates.
    init() {                                                        // Initializes the manager with sample data for demonstration purposes.
        // Sample data
        IncomeDetails.append(contentsOf: [                             // Each entry contains a name, amount, and additional details.
            IncomeDetail(Name: "Dine-In Sales", Amount: 950, Details: "Popular items: Gourmet Burgers, Chef: Alex Smith"),
            IncomeDetail(Name: "Takeaway Orders", Amount: 780, Details: "Includes online orders, Popular platform: QuickEats"),
            IncomeDetail(Name: "Private Dining", Amount: 1500, Details: "Event: Anniversary Dinner, Guests: 20"),
            IncomeDetail(Name: "Signature Cocktails", Amount: 420, Details: "Bestseller: Mango Mojito, Mixologist: Jamie Rivera"),
            IncomeDetail(Name: "Bakery Items", Amount: 330, Details: "Featured: Artisan Bread, Baker: Lucy Gomez"),
            IncomeDetail(Name: "Merchandise Sales", Amount: 220, Details: "Items: Branded Aprons and Cookbooks"),
            IncomeDetail(Name: "Workshops", Amount: 860, Details: "Workshop: Sushi Making, Instructor: Chef Sato"),
            IncomeDetail(Name: "Catering Services", Amount: 2100, Details: "Recent event: Wedding Reception, Guests: 100"),
            IncomeDetail(Name: "Seasonal Promotions", Amount: 650, Details: "Promotion: Summer Specials, Highlight: Seafood Platter"),
            IncomeDetail(Name: "Exclusive Tastings", Amount: 520, Details: "Theme: Wine and Cheese Night, Sommelier: Diane Quinn")
        ])
        ExpenseDetails.append(contentsOf: [                           // Each entry contains a name, amount, and additional details, along with a unique ID.
            ExpenseDetail(Name: "Food and Beverage Supplies", Amount: 1500.00, Details: "Includes bulk purchases of meat, vegetables, and specialty ingredients for the month."),
            ExpenseDetail(Name: "Staff Salaries", Amount: 1000.00, Details: "Monthly payroll for chefs, servers, and managerial staff."),
            ExpenseDetail(Name: "Rent", Amount: 2000.00, Details: "Monthly lease payment for restaurant premises in downtown."),
            ExpenseDetail(Name: "Utilities", Amount: 700.00, Details: "Electricity, gas, and water bills for the month."),
            ExpenseDetail(Name: "Equipment Maintenance", Amount: 750.00, Details: "Routine servicing of kitchen appliances and HVAC system."),
            ExpenseDetail(Name: "Marketing and Advertising", Amount: 500.00, Details: "Social media campaigns and local newspaper ads for upcoming promotions."),
            ExpenseDetail(Name: "Licenses and Permits", Amount: 500.00, Details: "Annual renewal of liquor license and health department permits."),
            ExpenseDetail(Name: "Taxes", Amount: 1200.00, Details: "Estimated quarterly sales and payroll taxes.")
        ])
        
        
    }
    var TotalIncome: Double {                                       // Computes the total income by summing the amounts of all income details.
        IncomeDetails.reduce(0) { $0 + $1.Amount }
    }
    var TotalExpenses: Double {                                     // Computes the total expenses by summing the amounts of all expense details.
            ExpenseDetails.reduce(0) { $0 + $1.Amount }
    }
    
    var isProfit: Bool {                                             // Determines if the business is currently profitable.
        TotalIncome > TotalExpenses
    }
    var isBreakEven: Bool {                                         // Determines if the business is breaking even.
        TotalIncome == TotalExpenses
    }
    func CalculateProfitLossPercent() -> Double {                   // Calculates the profit or loss percentage relative to the total expenses.
        let profitloss = TotalIncome - TotalExpenses
        guard TotalExpenses != 0 else{
            return 0
        }
        return (profitloss/TotalExpenses) * 100
    }
    
    func addIncomeDetail(Name: String, Amount: Double, Details: String) {                       // Adds a new income detail to the collection.
        let detail = IncomeDetail(Name: Name, Amount: Amount, Details: Details)
        IncomeDetails.append(detail)
    }
    func modifyIncomeDetail(index:Int,newName:String,newAmount: Double,newDetails: String) {                 // Modifies an existing income detail by index.
        guard IncomeDetails.indices.contains(index) else {return}
        DispatchQueue.main.async{
            self.IncomeDetails[index] = IncomeDetail(Name: newName,Amount: newAmount,Details: newDetails)
        }
    }
    func addExpenseDetail(Name: String, Amount: Double, Details: String) {                                  // Adds a new expense detail to the collection.
        let detail = ExpenseDetail(Name: Name, Amount: Amount, Details: Details)
        ExpenseDetails.append(detail)
    }
    func modifyExpenseDetail(id:UUID ,newName:String?,newAmount: Double?,newDetails: String?) {     // Modifies an existing expense detail by its unique ID.
        guard let index = ExpenseDetails.firstIndex(where:{ $0.id == id}) else { return }
        DispatchQueue.main.async{
            if let newName = newName { self.ExpenseDetails[index].Name = newName }
            if let newAmount = newAmount { self.ExpenseDetails[index].Amount = newAmount }
            if let newDetails = newDetails { self.ExpenseDetails[index].Details = newDetails }
        }
    }
}
