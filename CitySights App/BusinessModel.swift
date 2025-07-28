//
//  BusinessModel.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 7/13/25.
//

import Foundation
import SwiftUI
import CoreLocation


@Observable 
class BusinessModel: NSObject, CLLocationManagerDelegate {
    
    var businesses = [Business]()
    var query: String = ""
    var selectedBusiness: Business?
    
    var service = DataService()
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getBusinesses() {
        
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation)
        }
        
    }
    
    func getUserLocation() {
        // Check if we have permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Detect if user is allowed, then request location.
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            manager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentUserLocation = locations.last?.coordinate
        
        if currentUserLocation != nil {
            // Call business Search
            getBusinesses()
        }
        manager.stopUpdatingLocation()
    }
    
}
