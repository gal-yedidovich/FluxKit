//
//  StoreTests.swift
//  
//
//  Created by Gal Yedidovich on 27/11/2021.
//

import XCTest
@testable import FluxTest

final class StoreTests: XCTestCase {
	
	func testStoreShouldContainInitialValue() {
		//Given
		let data = TestData(name: "Groot", isAlive: true, age: 100)
		
		//When
		let store = Store(initialState: data, reducer: testReducer)
		
		//Then
		XCTAssertEqual(store.state, data)
	}
	
	func testStoreShouldChangeStateOnDispatch() {
		//Given
		let EXPECTED_NAME = "Bubu"
		let store = Store(initialState: TestData(), reducer: testReducer)
		
		//When
		store.dispatch(action: .changeName(EXPECTED_NAME));
		
		//Then
		XCTAssertEqual(store.state.name, EXPECTED_NAME)
	}
}

fileprivate struct TestData: Equatable {
	var name = ""
	var isAlive = true
	var age = 0
}

fileprivate enum TestAction {
	case changeName(String)
}

fileprivate func testReducer(state: TestData, action: TestAction) -> TestData {
	var copy = state;
	switch action {
	case .changeName(let newName):
		copy.name = newName
	}
	return copy
}
