//
//  BusinessDetailView.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/29/25.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business?
    
    var body: some View {
        Text(business?.name ?? "")
    }
}

#Preview {
    BusinessDetailView()
}
