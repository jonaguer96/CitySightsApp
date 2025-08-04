//
//  ContentView.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/25/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(BusinessModel.self) var model
    @State var query = ""
    @State var selectedTab = 0
    @State var popularOn = false
    @State var dealsOn = false
    @State var categorySelection = "restaurants"
    
    var body: some View {
        
        @Bindable var model = model
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                Button {
                    // Perform Search
                    model.getBusinesses(query: query, options: getOptionsString(), category: categorySelection)
                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .frame(height: 32)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }
            }
            .padding(.horizontal)
            
            // Query options
            VStack {
                Toggle("Popular", isOn: $popularOn)
                Toggle("Deals", isOn: $dealsOn)
                
                HStack {
                    Text("Categories")
                    Spacer()
                    Picker("Category", selection: $categorySelection) {
                        Text("Restaurants")
                            .tag("restaurants")
                        Text("Arts")
                            .tag("arts")
                        Text("Pets")
                            .tag("pets")
                    }
                }
            }
            .padding(.horizontal, 40)
            
            //Show picker
            Picker ("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            //Show map or list
            if selectedTab == 1 {
                MapView()
            }
            else {
                ListView()
            }
        }
        .onAppear {
            model.getBusinesses(query: nil, options: nil, category: nil)
        }
        .sheet(item: $model.selectedBusiness) { item in
            BusinessDetailView()
        }
    }
    
    func getOptionsString() -> String {
        var optionsArray = [String]()
        if popularOn {
            optionsArray.append("hot_and_new")
        }
        if dealsOn {
            optionsArray.append("deals")
        }
        return optionsArray.joined(separator: ",")
    }
}


#Preview {
    HomeView()
        .environment(BusinessModel())
}
