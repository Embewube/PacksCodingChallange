//
//  PackMapper.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

protocol PackMapping {
    func map(_ pack: Pack) -> PackListItem
    func map(_ packs: [Pack]) -> [PackListItem]
    func map(_ packSection: PackSection) -> PackListSection
    func map(_ packSections: [PackSection]) -> [PackListSection]
}

struct PackMapper: PackMapping {
    func map(_ pack: Pack) -> PackListItem {
        return PackListItem(
            id: pack.id,
            status: pack.status.rawValue,
            sender: pack.sender
        )
    }

    func map(_ packs: [Pack]) -> [PackListItem] {
        return packs.map(map)
    }

    func map(_ packSection: PackSection) -> PackListSection {
        return PackListSection(
            title: packSection.type.rawValue,
            items: map(packSection.packs)
        )
    }

    func map(_ packSections: [PackSection]) -> [PackListSection] {
        return packSections.map(map)
    }
}
