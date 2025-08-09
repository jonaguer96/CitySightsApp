//
//  DataService.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/28/25.
//

import Foundation
import CoreLocation

struct DataService {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category: String?) async -> [Business] {
        
        // Check if API key exists
        guard apiKey != nil else {
            return [Business]()
        }
        // Default lat long
        var lat = 37.785834
        var long = -122.406417
        // User lat long
        if let userLocation = userLocation {
            lat = userLocation.latitude
            long = userLocation.longitude
        }
        
        var endpointUrlString = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&categories=restaurants&limit=10"
        
        //Add query
        if query != nil && query != "" {
            endpointUrlString.append("&term=\(query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        }
        //Add options
        if options != nil && options != "" {
            endpointUrlString.append("&attributes=\(options!)")
        }
        //Add category
        if let category = category {
            endpointUrlString.append("&category=\(category)")
        }
        
        
        // 1. Create url
        if let url = URL(string: endpointUrlString){
            
            // 2. Create request
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            
            // 3. Send request
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                
                // 4. Parse the JSON
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                return result.businesses
                
                
            }
            catch {
                print(error)
            }
        }
        
        return [Business]()
    }
    
}
