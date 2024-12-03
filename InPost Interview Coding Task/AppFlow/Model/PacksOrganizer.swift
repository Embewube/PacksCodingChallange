//
//  PacksOrganizer.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

protocol PacksOrganizing {
    func group(packs: [Pack]) -> [PackSection]
}

struct PacksOrganizer {}

extension PacksOrganizer: PacksOrganizing {
    func group(packs: [Pack]) -> [PackSection] {
        var readyPacks: [Pack] = []
        var otherPacks: [Pack] = []

        packs.forEach {
            if $0.status == .readyToPickup || $0.status == .outForDelivery {
                readyPacks.append($0)
            } else {
                otherPacks.append($0)
            }
        }
        
        return [
            PackSection(
                type: .readyToPickup,
                packs: readyPacks
            ),
            PackSection(
                type: .others,
                packs: otherPacks
            )
        ]
    }
}
