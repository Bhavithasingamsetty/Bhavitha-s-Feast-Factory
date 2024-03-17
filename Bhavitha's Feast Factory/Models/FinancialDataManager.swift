//
//  FinancialManager.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import Combine
import Foundation

class FinancialDataManager: ObservableObject {
    struct IncomeDetail {
        let Name: String
        let Amount: Double
        let Details: String
    }
    struct ExpenseDetail : Identifiable{
        let id : UUID = UUID()
        var Name: String
        var Amount: Double
        var Details: String
    }
    
    @Published var IncomeDetails: [IncomeDetail] = []
    @Published var TotalExpenses: Double = 0
    @Published var ExpenseDetails: [ExpenseDetail] = []
    init() {
        // Sample data
        IncomeDetails.append(contentsOf: [
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
        ExpenseDetails.append(contentsOf: [
            ExpenseDetail(Name: "Food and Beverage Supplies", Amount: 12500.00, Details: "Includes bulk purchases of meat, vegetables, and specialty ingredients for the month."),
            ExpenseDetail(Name: "Staff Salaries", Amount: 18000.00, Details: "Monthly payroll for chefs, servers, and managerial staff."),
            ExpenseDetail(Name: "Rent", Amount: 8000.00, Details: "Monthly lease payment for restaurant premises in downtown."),
            ExpenseDetail(Name: "Utilities", Amount: 2500.00, Details: "Electricity, gas, and water bills for the month."),
            ExpenseDetail(Name: "Equipment Maintenance", Amount: 750.00, Details: "Routine servicing of kitchen appliances and HVAC system."),
            ExpenseDetail(Name: "Marketing and Advertising", Amount: 2200.00, Details: "Social media campaigns and local newspaper ads for upcoming promotions."),
            ExpenseDetail(Name: "Licenses and Permits", Amount: 500.00, Details: "Annual renewal of liquor license and health department permits."),
            ExpenseDetail(Name: "Insurance", Amount: 1200.00, Details: "Monthly premium for property, liability, and workers' compensation insurance."),
            ExpenseDetail(Name: "Supplies", Amount: 1800.00, Details: "Purchase of napkins, cleaning supplies, and guest check presenters."),
            ExpenseDetail(Name: "Waste Removal", Amount: 300.00, Details: "Monthly contract fee for garbage and recycling services."),
            ExpenseDetail(Name: "Professional Services", Amount: 1500.00, Details: "Quarterly consultation with a restaurant management consultant."),
            ExpenseDetail(Name: "Taxes", Amount: 7000.00, Details: "Estimated quarterly sales and payroll taxes.")
        ])
        
        
    }
    var TotalIncome: Double {
        IncomeDetails.reduce(into: 0) { $0 + $1.Amount }
    }
    
    var isProfit: Bool {
        TotalIncome > TotalExpenses
    }
    var isBreakEven: Bool {
        TotalIncome == TotalExpenses
    }
    func CalculateProfitLossPercent() -> Double {
        let profitloss = TotalIncome - TotalExpenses
        guard TotalExpenses != 0 else{
            return 0
        }
        return (profitloss/TotalExpenses) * 100
    }
    
    func addIncomeDetail(Name: String, Amount: Double, Details: String) {
        let detail = IncomeDetail(Name: Name, Amount: Amount, Details: Details)
        IncomeDetails.append(detail)
    }
    func modifyIncomeDetail(index:Int,newName:String,newAmount: Double,newDetails: String) {
        guard IncomeDetails.indices.contains(index) else {return}
        DispatchQueue.main.async{
            self.IncomeDetails[index] = IncomeDetail(Name: newName,Amount: newAmount,Details: newDetails)
        }
    }
    func addExpenseDetail(Name: String, Amount: Double, Details: String) {
        let detail = ExpenseDetail(Name: Name, Amount: Amount, Details: Details)
        ExpenseDetails.append(detail)
    }
    func modifyExpenseDetail(id:UUID ,newName:String?,newAmount: Double?,newDetails: String?) {
        guard let index = ExpenseDetails.firstIndex(where:{ $0.id == id}) else { return }
        DispatchQueue.main.async{
            if let newName = newName { self.ExpenseDetails[index].Name = newName }
            if let newAmount = newAmount { self.ExpenseDetails[index].Amount = newAmount }
            if let newDetails = newDetails { self.ExpenseDetails[index].Details = newDetails }
        }
    }
}
