//
//  PackListItem.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

struct PackListItem: Equatable {
    let id: String
    let status: String
    let sender: String
    let iconName: String
    let isExpirationHidden: Bool
    let expirationValue: String?
    let expirationLabel: String?
}
