//
//  FluxStoreTests.swift
//  
//
//  Created by Gal Yedidovich on 27/11/2021.
//

import XCTest
@testable import FluxKit

final class FluxStoreTests: XCTestCase {
	
	func testStoreShouldContainInitialValue() {
		//Given
		let data = TestData(name: "Groot", isAlive: true, age: 100)
		
		//When
		let store = FluxStore(initialState: data, reducer: testReducer)
		
		//Then
		XCTAssertEqual(store.state, data)
	}
	
	func testStoreShouldChangeStateOnDispatch() {
		//Given
		let EXPECTED_NAME = "Bubu"
		let store = FluxStore(initialState: TestData(), reducer: testReducer)
		
		//When
		store.dispatch(action: .changeName(EXPECTED_NAME));
		
		//Then
		XCTAssertEqual(store.state.name, EXPECTED_NAME)
	}
	
	func testStoreShouldCallOnUpdateAfterDispatch() {
		//Given
		var flag = false
		let store = FluxStore(initialState: TestData(),
						  reducer: testReducer,
						  onUpdate: { _ in flag = true })
		
		//When
		store.dispatch(action: .changeName("Bubu"));
		
		//Then
		XCTAssertTrue(flag)
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
