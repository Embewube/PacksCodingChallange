//
//  PacksSorter.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

protocol PacksSorting {
    func sortPacks(in packsSections: [PackSection]) -> [PackSection]
}

struct PacksSorter {}

extension PacksSorter: PacksSorting {
    func sortPacks(in packsSections: [PackSection]) -> [PackSection] {
        // wb_NOTE: complexity O(n^2). For grater amount of data, consider changing algorithm including grouping algorithm as well
        // I find a SortDescriptor an overkill for this purpose
        return packsSections.map { section in
            return PackSection(
                type: section.type,
                packs: sort(section.packs)
            )
        }
    }
}

private extension PacksSorter {
    private func sort(_ packs: [Pack]) -> [Pack] {
        return packs.sorted {
            if $0.status != $1.status {
                return $0.status.priority < $1.status.priority
            }

            if $0.pickupDate != $1.pickupDate {
                return ($0.pickupDate ?? .distantFuture) < ($1.pickupDate ?? .distantFuture)
            }

            if $0.expiryDate != $1.expiryDate {
                return ($0.expiryDate ?? .distantFuture) < ($1.expiryDate ?? .distantFuture)
            }

            if $0.storedDate != $1.storedDate {
                return ($0.storedDate ?? .distantFuture) < ($1.storedDate ?? .distantFuture)
            }

            return $0.id < $1.id
        }
    }
}

