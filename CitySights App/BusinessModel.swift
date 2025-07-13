//
//  BusinessModel.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 7/13/25.
//

import Foundation
import SwiftUI


@Observable 
class BusinessModel {
    
    var businesses = [Business]()
    var query: String = ""
    var selectedBusiness: Business?
    
    var service = DataService()
    
    func getBusinesses() {
        
        Task {
            businesses = await service.businessSearch()
        }
        
    }
    
}
