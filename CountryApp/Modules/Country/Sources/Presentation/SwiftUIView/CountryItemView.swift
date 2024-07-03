//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 6/10/24.
//

import SwiftUI
//import SDWebImageSwiftUI

struct CountryItemView: View {
    
    let countryEntity: CountryEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                WebImage(url: URL(string: countryEntity.flag),
//                         options: [],
//                         context: [.imageThumbnailPixelSize : CGSize.zero])
//                    .placeholder { ProgressView()}
//                    .resizable()
//                    .frame(width: 50, height: 50)

                Text("\(countryEntity.name), \(countryEntity.region)")
                    .frame(alignment: .topLeading)
                    .font(.title)
                    .bold()
                Spacer()
                Text(countryEntity.code)
                    .font(.title3)
            }
            Text(countryEntity.capital)
                .font(.subheadline)
                .foregroundColor(.gray)
        }.padding()
    }
}

#Preview {
    CountryItemView(countryEntity: CountryEntity(name: "Name", region: "Region", code: "Code", capital: "Capital", flag: "https://restcountries.eu/data/vir.svg"))
}
