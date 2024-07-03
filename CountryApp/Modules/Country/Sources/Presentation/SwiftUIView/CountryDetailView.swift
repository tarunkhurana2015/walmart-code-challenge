//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 6/11/24.
//

import SwiftUI

// https://www.bigmountainstudio.com/blog/customize-navigationstack
struct CountryDetailView: View {
    
    let countryEntity: CountryEntity
    
    var body: some View {
        ScrollView {
            NavigationView {
                AsyncImage(url: URL(string: "https://static.magflags.net/media/catalog/product/cache/75170699113cf9b1963820a3ea1bab40/T/H/TH-94.png")) { phase in
                    switch phase {
                    case let .success(image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 700)
                            .transition(.opacity)
                    case .empty:
                        ProgressView()
                    default:
                        Color.clear
                    }
                }
                 
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
}

#Preview {
    CountryDetailView(countryEntity: CountryEntity(name: "Name", region: "Region", code: "Code", capital: "Capital", flag: "https://static.magflags.net/media/catalog/product/cache/75170699113cf9b1963820a3ea1bab40/T/H/TH-94.png"))
}
