//
//  UtilitiesView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var financialManager = FinancialDataManager() // Initialized with sample data
    var body: some View {
        NavigationView{
            VStack {
                Text("Bhavitha's Feast Factory")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 50)
            
                NavigationLink(destination: UtilitiesView(financialManager: financialManager)){ Image("Firstscreenlogo")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: 400, height: 300) // Adjust the frame as needed
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.green, lineWidth: 4)) // Optional: Adds a border to the circle
                        .shadow(radius: 10) // Optional: Adds a shadow effect
                        .padding(.top, 50)
                }
                
                
                Spacer() // Pushes everything to the top
                
            }
            .padding()
    }
}
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

