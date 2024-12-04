//
//  PackMapper.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

import Foundation

protocol PackMapping {
    func map(_ pack: Pack) -> PackListItem
    func map(_ packs: [Pack]) -> [PackListItem]
    func map(_ packSection: PackSection) -> PackListSection
    func map(_ packSections: [PackSection]) -> [PackListSection]
}

struct PackMapper: PackMapping {
    func map(_ pack: Pack) -> PackListItem {

        // wb_TODO: inject custom formatter
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter
        }()

        let expiration: String? = {
            guard let expiryDate = pack.expiryDate else { return nil }
            return dateFormatter.string(from: expiryDate)
        }()

        return PackListItem(
            id: pack.id,
            status: extractStatus(from: pack.status),
            sender: pack.sender,
            iconName: extractIconName(from: pack.shipmentType),
            isExpirationHidden: expiration == nil,
            expiration: expiration
        )
    }

    func map(_ packs: [Pack]) -> [PackListItem] {
        return packs.map(map)
    }

    func map(_ packSection: PackSection) -> PackListSection {
        return PackListSection(
            title: packSection.type.title,
            items: map(packSection.packs)
        )
    }

    func map(_ packSections: [PackSection]) -> [PackListSection] {
        return packSections.map(map)
    }
}

private extension PackMapper {
    private func extractIconName(from shipmentType: Pack.ShipmentType) -> String {
        return switch shipmentType {
        case .courier:      "CourierIcon"
        case .parcelLocker: "ParcelLockerIcon"
        case .unknown:      ""
        }
    }

    // wb_TODO: Single responsibility - create another mapper
    private func extractStatus(from status: Pack.Status) -> String {
        return switch status {
        case .outForDelivery:   "Wydana do doręczenia"
        case .readyToPickup:    "Gotowa do odbioru"
        case .delivered:        "Odebrana"
        default:                status.rawValue
        }
    }
}
