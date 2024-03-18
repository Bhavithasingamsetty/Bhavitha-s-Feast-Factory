//
//  UtilitiesView.swift
//  Bhavitha's Feast Factory
//
//  Created by Singamsetty, Bhavitha on 3/16/24.
//
import SwiftUI

struct ContentView: View {                                                                          // StateObject to hold and manage financial data
    @StateObject var financialManager = FinancialDataManager()                                                   // Initialized with sample data

    var body: some View {
        NavigationView {
            VStack {                                                                                             // App title at the top of the screen
                Text("Bhavitha's Feast Factory")
                    .font(.title)                                                                                // Set the font size to title
                    .fontWeight(.bold)                                                                           // Make the font weight bold
                    .padding(.top, 50)                                                                           // Add padding at the top for spacing

                NavigationLink(destination: UtilitiesView(financialManager: financialManager)) {                  // Navigation link to go to the Utilities view   // On tap, it will navigate to a detailed view for utilities
                    
                    Image("Firstscreenlogo")                                                                      // Logo of the restaurant that acts as a button for navigation
                        .resizable()                                                                              // Make the image resizable
                        .aspectRatio(contentMode: .fill)                                                          // Fill the frame with the image aspect ratio
                        .frame(width: 400, height: 300)                                                           // Set the frame size of the image
                        .clipShape(Circle())                                                                      // Clip the  image to a circle shape
                        .overlay(Circle().stroke(Color.green, lineWidth: 4))                                      // Optional: Adds a green border to the circle
                        .shadow(radius: 10)                                                                       // Optional: Adds a shadow effect for depth
                        .padding(.top, 50)                                                                        // Add padding at the top for spacing
                }
                
                Spacer()                                                                                         // Pushes everything to the top, ensuring the logo is centered on the screen
            }
            .padding()                                                                                          // Add padding around the VStack contents
            .background(
                                                                                                                // Use Image("YourBackgroundImageName") for a specific image or Color for a solid color.
                    Image("smoothie")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.2)                                                                  // Adjust the opacity to make the background image appear dull.
                                .edgesIgnoringSafeArea(.all)               // Ensure the background extends to the screen edges.
                        )
        }
    }
}

struct ContentView_Previews: PreviewProvider {                                                                  // SwiftUI Preview for the ContentView
    static var previews: some View {
        ContentView()
    }
}
