//
//  PlaceCard.Model.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation

extension PlaceCard {
    struct Model: Identifiable {
        var id: String
        var imageUrl: URL?
        var name: String
        var type: String?
        var distance: Int?
    }
}