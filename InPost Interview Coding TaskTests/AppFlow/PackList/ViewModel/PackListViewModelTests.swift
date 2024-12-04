//
//  PackListViewModelTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import XCTest
import Combine
@testable import InPost_Interview_Coding_Task

final class PackListViewModelTests: XCTestCase {
    private enum Constants {
        static let simulatedPackListItem = PackListItem(
            id: "any id",
            status: "any status",
            sender: "any sender",
            iconName: "any icon name",
            isExpirationHidden: false,
            expirationValue: "any expiration value",
            expirationLabel: "any expiration label"
        )
        static let simulatedPackList = [
            PackListSection(
                title: "any title",
                items: [simulatedPackListItem]
            )
        ]
    }

    private var sut: PackListViewModel?
    private var getPacksUseCaseMock: GetPacksUseCaseMock?

    private var cancellables: Set<AnyCancellable> = []

    override func tearDown() {
        sut = nil
        getPacksUseCaseMock = nil
        cancellables = []

        super.tearDown()
    }

    func test_loadPacks_asksGetPacksUseCase() throws {
        // given
        prepareTestDoubles()
        let sut = try XCTUnwrap(sut)
        let getPacksUseCaseMock = try XCTUnwrap(getPacksUseCaseMock)

        // when
        sut.loadPacks()

        // then
        getPacksUseCaseMock.observableHistory.dropFirst()
            .sink { history in
                XCTAssertEqual(history, [.get])
            }
            .store(in: &cancellables)
    }

    func test_loadPacks_updatesPacks() throws {
        // given
        let simulatedResult = Constants.simulatedPackList
        prepareTestDoubles(getPackSimulatedResult: .success(simulatedResult))
        let sut = try XCTUnwrap(sut)

        // when
        sut.loadPacks()

        // then
        sut.packs.dropFirst().sink { result in
            XCTAssertEqual(result, simulatedResult)
        }
        .store(in: &cancellables)
    }

    func test_loadPacks_updatesPacksToEmptyArray_whenGetPacksUseCaseFails() throws {
        // given
        let simulatedError = TestError.fail
        prepareTestDoubles(getPackSimulatedResult: .failure(simulatedError))
        let sut = try XCTUnwrap(sut)

        // when
        sut.loadPacks()

        // then
        sut.packs.dropFirst().sink { result in
            XCTAssertEqual(result, [])
        }
        .store(in: &cancellables)
    }

}

private extension PackListViewModelTests {
    private enum TestError: Error {
        case fail
    }

    private func prepareTestDoubles(
        getPackSimulatedResult: Result<[PackListSection], Error> = .success([])
    ) {
        let getPacksUseCaseMock = GetPacksUseCaseMock(simulatedResult: getPackSimulatedResult)
        self.getPacksUseCaseMock = getPacksUseCaseMock

        sut = PackListViewModel(getPacksUseCase: getPacksUseCaseMock)
    }
}
