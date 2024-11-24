//
//  PlacesManager.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation
import MapKit
import Observation

@Observable
class PlaceManager {    
    var webservice: WebserviceClient = .live

    var places: [Place] = []

    var isLoading: Bool { task?.isCancelled == false }
    var task: Task<Void, Error>?
    var nextURL: URL?

    func onLastAppear() {
        guard task == nil else { return }
        guard let nextURL else { return }

        task = Task {
            defer { task = nil }
            (places, self.nextURL) = try await webservice.getPlacesNextPage(nextURL)
        }
    }

    func onSearchTap(coordinate: CLLocationCoordinate2D, distance: Double) {
        task?.cancel()
        places = []

        task = Task {
            defer { task = nil }
            let coordinate = "\(coordinate.latitude),\( coordinate.longitude)"
            let distance = Int(distance)
            (places, nextURL) = try await webservice.getPlaces(
                coordinate: coordinate,
                radius: distance,
                query: nil
            )
        }
    }
    
    func onSearchSubmit(text: String) {
        task?.cancel()
        places = []

        task = Task {
            defer { task = nil }
            (places, nextURL) = try await webservice.getPlaces(
                coordinate: nil,
                radius: nil,
                query: text
            )
        }
    }
}
