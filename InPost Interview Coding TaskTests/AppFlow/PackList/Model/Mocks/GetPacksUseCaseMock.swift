//
//  GetPacksUseCaseMock.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import Combine
@testable import InPost_Interview_Coding_Task

public final class GetPacksUseCaseMock {
    public enum Action: Equatable {
        case get
    }

    public private(set) var observableHistory = CurrentValueSubject<[Action], Never>([])

    public var history: [Action] {
        return observableHistory.value
    }

    private let simulatedResult: Result<[PackListSection], Error>

    public init(
        simulatedResult: Result<[PackListSection], Error>
    ) {
        self.simulatedResult = simulatedResult
    }
}

extension GetPacksUseCaseMock: GetPacksUseCaseProtocol {
    public func get() async throws -> [PackListSection] {
        let action = Action.get
        observableHistory.value.append(action)

        return try simulatedResult.get()
    }
}
