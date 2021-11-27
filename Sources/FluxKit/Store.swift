//
//  Store.swift
//  
//
//  Created by Gal Yedidovich on 27/11/2021.
//

import Foundation
import Combine

public class Store<State, Action>: ObservableObject {
	public typealias Reducer = (State, Action) -> State
	public typealias OnUpdate = (State) -> Void
	
	@Published internal(set) public var state: State
	private let reducer: Reducer
	private let onUpdate: OnUpdate?
	
	public init(initialState: State,
				reducer: @escaping Reducer,
				onUpdate: OnUpdate? = nil) {
		self.state = initialState
		self.reducer = reducer
		self.onUpdate = onUpdate
	}
	
	public func dispatch(action: Action) {
		let newState = reducer(state, action)
		self.state = newState
		
		onUpdate?(state)
	}
}
