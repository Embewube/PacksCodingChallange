//
//  PackSection.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

struct PackSection {
    enum SectionType: String {
        case readyToPickup
        case others

        var title: String {
            switch self {
            case .readyToPickup:    return "Gotowe do odbioru" // wb_TODO: use translations
            case .others:           return "Pozostałe"
            }
        }
    }

    let type: SectionType
    let packs: [Pack]
}
