//
//  Pack.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import Foundation

/**
 * List of possible statuses with priority order.
 * 1. CREATED
 * 2. CONFIRMED
 * 3. ADOPTED_AT_SOURCE_BRANCH
 * 4. SENT_FROM_SOURCE_BRANCH
 * 5. ADOPTED_AT_SORTING_CENTER
 * 6. SENT_FROM_SORTING_CENTER
 * 7. OTHER
 * 8. DELIVERED
 * 9. RETURNED_TO_SENDER
 * 10. AVIZO
 * 11. OUT_FOR_DELIVERY
 * 12. READY_TO_PICKUP
 * 13. PICKUP_TIME_EXPIRED
 */

struct Pack: Codable {
    enum Status: String, Codable {
        case created = "CREATED"
        case confirmed = "CONFIRMED"
        case adoptedAtSourceBranch = "ADOPTED_AT_SOURCE_BRANCH"
        case sentFromSourceBranch = "SENT_FROM_SOURCE_BRANCH"
        case adoptedAtSortingCenter = "ADOPTED_AT_SORTING_CENTER"
        case sentFromSortingCenter = "SENT_FROM_SORTING_CENTER"
        case other = "OTHER"
        case delivered = "DELIVERED"
        case returnedToSender = "RETURNED_TO_SENDER"
        case avizo = "AVIZO"
        case outForDelivery = "OUT_FOR_DELIVERY"
        case readyToPickup = "READY_TO_PICKUP"
        case pickupTimeExpired = "PICKUP_TIME_EXPIRED"
        case unknown

        init(from decoder: any Decoder) throws {
            let rawValue: String = try decoder.singleValueContainer().decode(String.self)
            self = Status(rawValue: rawValue) ?? .unknown
        }
    }

    enum ShipmentType: String, Codable {
        case courier = "COURIER"
        case parcelLocker = "PARCEL_LOCKER"
        case unknown
        
        init(from decoder: any Decoder) throws {
            let rawValue: String = try decoder.singleValueContainer().decode(String.self)
            self = ShipmentType(rawValue: rawValue) ?? .unknown
        }
    }

    let id: String
    let status: Status
    let sender: String
    let expiryDate: Date?
    let pickupDate: Date?
    let storedDate: Date?
    let shipmentType: ShipmentType
}
