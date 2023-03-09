//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Daniel Konnek on 7.03.2023.
//

import SwiftUI

struct ContentView: View {
    var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favourites = Favourites()
    @State private var searchText = ""
    @State private var showConfirmationDialog = false
    @State private var sortMethod: SortingMethods = .defaultOrder
    
    enum SortingMethods {
        case defaultOrder, alphabeticalOrder, countryOrder
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favourites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showConfirmationDialog = true
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
            .confirmationDialog("Choose sorting method", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                Button("Default") { sortMethod = .defaultOrder }
                Button("Alphabetical") { sortMethod = .alphabeticalOrder }
                Button("Country") { sortMethod = .countryOrder }
//                Button("Cancel", role: .cancel) { }
            }
            
            WelcomeView()
        }
        .environmentObject(favourites)
        
    }
    
    var filteredResorts: [Resort] {
        var orderedResorts: [Resort]
        switch sortMethod {
        case .countryOrder:
            orderedResorts = resorts.sorted { $0.country < $1.country }
        case .alphabeticalOrder:
            orderedResorts = resorts.sorted { $0.name < $1.name }
        default:
            orderedResorts = resorts
        }
        
        if searchText.isEmpty {
            return orderedResorts
        } else {
            return orderedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
