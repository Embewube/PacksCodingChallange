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
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E. | dd.MM.yy | HH:mm"
        return formatter
    }()

    func map(_ pack: Pack) -> PackListItem {
        let (expirationLabel, expirationValue) = extractExpiration(from: pack)

        return PackListItem(
            id: pack.id,
            status: extractStatus(from: pack.status),
            sender: pack.sender,
            iconName: extractIconName(from: pack.shipmentType),
            isExpirationHidden: expirationValue == nil,
            expirationValue: expirationValue,
            expirationLabel: expirationLabel
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

    private func extractExpiration(from pack: Pack) -> (expirationLabel: String?, expirationValue: String?) {
        var date: Date?
        var expirationLabel: String?
        switch pack.status {
        case .readyToPickup:
            date = pack.expiryDate
            expirationLabel = "CZEKA NA ODBIÓR"
        case .delivered:
            date = pack.pickupDate
            expirationLabel = "ODEBRANA"
        default:
            return (nil, nil)
        }

        guard let date else {
            return (nil, nil)
        }
        return (expirationLabel, dateFormatter.string(from: date))
    }
}
