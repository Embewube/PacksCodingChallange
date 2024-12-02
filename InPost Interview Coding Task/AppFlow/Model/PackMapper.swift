//
//  PackMapper.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

protocol PackMapping {
    func map(_ pack: Pack) -> PackListItemViewModel
}

struct PackMapper: PackMapping {
    func map(_ pack: Pack) -> PackListItemViewModel {
        return PackListItemViewModel(
            id: pack.id,
            status: pack.status,
            sender: pack.sender
        )
    }
}
