//
//  Store.swift
//  
//
//  Created by Gal Yedidovich on 27/11/2021.
//

import Foundation

public class Store<State, Action>: ObservableObject {
	public typealias Reducer = (State, Action) -> State
	
	@Published public private(set) var state: State
	private let reducer: Reducer
	
	public init(initialState: State, reducer: @escaping Reducer) {
		self.state = initialState
		self.reducer = reducer
	}
	
	public func dispatch(action: Action) {
		let newState = reducer(state, action)
		self.state = newState
	}
}
