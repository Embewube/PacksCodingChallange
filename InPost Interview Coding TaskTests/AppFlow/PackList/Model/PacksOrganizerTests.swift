//
//  PacksOrganizerTests.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import XCTest
@testable import InPost_Interview_Coding_Task

// wb_NOTE: example of unit tests for a class without dependencies. I considered parametrized tests, but the structure of data is too complex to have readable parametrized tests

final class PacksOrganizerTests: XCTestCase {
    private enum Constants {
        static let packsWithReadyStatus = [
            Pack(status: .readyToPickup),
            Pack(status: .outForDelivery),
        ]
        static let packsWithOtherStatus = [
            Pack(status: .created),
            Pack(status: .confirmed),
            Pack(status: .adoptedAtSourceBranch),
            Pack(status: .sentFromSourceBranch),
            Pack(status: .adoptedAtSortingCenter),
            Pack(status: .sentFromSortingCenter),
            Pack(status: .other),
            Pack(status: .delivered),
            Pack(status: .returnedToSender),
            Pack(status: .avizo),
            Pack(status: .pickupTimeExpired),
            Pack(status: .unknown),
        ]
    }

    func test_groupPacks_returns2DifferentSections() {
        //  given
        let sut = PacksOrganizer()

        // when
        let result = sut.group(packs: [])

        // then
        XCTAssertEqual(result.count, 2)
        XCTAssertNotEqual(result[0].type, result[1].type)
    }

    func test_groupPacks_returnsGroupedReadyToPickupPacks_whenThereAreOnlyReadyToPickupPacks() {
        // given
        let packs = Constants.packsWithReadyStatus
        let sut = PacksOrganizer()

        // when
        let result = sut.group(packs: packs)

        // then
        let expectedResult = [
            PackSection(
                type: .readyToPickup,
                packs: packs
            ),
            PackSection(
                type: .others,
                packs: []
            ),
        ]

        XCTAssertEqual(result, expectedResult)
    }

    func test_groupPacks_returnsGroupedOtherPacks_whenThereAreOnlyOtherPacks() {
        // given
        let packs = Constants.packsWithOtherStatus
        let sut = PacksOrganizer()

        // when
        let result = sut.group(packs: packs)

        // then
        let expectedResult = [
            PackSection(
                type: .readyToPickup,
                packs: []
            ),
            PackSection(
                type: .others,
                packs: packs
            ),
        ]

        XCTAssertEqual(result, expectedResult)
    }

    func test_groupPacks_returnsGroupedAllPacks() {
        // given
        let readyPacks = Constants.packsWithReadyStatus
        let otherPacks = Constants.packsWithOtherStatus
        let sut = PacksOrganizer()

        // when
        let result = sut.group(packs: readyPacks + otherPacks)

        // then
        let expectedResult = [
            PackSection(
                type: .readyToPickup,
                packs: readyPacks
            ),
            PackSection(
                type: .others,
                packs: otherPacks
            ),
        ]

        XCTAssertEqual(result, expectedResult)
    }
}

private extension Pack {
    init(status: Pack.Status) {
        self.init(
            id: "any id",
            status: status,
            sender: "any sender",
            expiryDate: nil,
            pickupDate: nil,
            storedDate: nil,
            shipmentType: .unknown
        )
    }
}

