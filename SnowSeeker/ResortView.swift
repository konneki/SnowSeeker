//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Daniel Konnek on 8.03.2023.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailView(resort: resort) }
                    } else {
                        ResortDetailView(resort: resort)
                        SkiDetailView(resort: resort)
                    }
                }
                .padding()
                .background(.primary.opacity(0.1))
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
    }
}
