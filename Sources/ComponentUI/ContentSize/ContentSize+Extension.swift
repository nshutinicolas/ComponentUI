//
//  ContentSize+Extension.swift
//  ComponentUI
//
//  Created by Musoni nshuti Nicolas on 01/02/2025.
//

import SwiftUI

extension View {
	/// Get view size
	/// - Parameters:
	/// 	- size: CGSize binding
	/// - Returns: View
	public func size(_ size: Binding<CGSize>) -> some View {
		modifier(ContentSizeViewModifier(size: size))
	}
	
	/// Get view frame
	/// - Parameters:
	/// 	- size: CGSize binding
	/// - Returns: View
	public func frame(_ frame: Binding<CGRect>, in coordinateSpace: CoordinateSpace = .global) -> some View {
		modifier(ContentFrameViewModifier(frame: frame, coordinateSpace: coordinateSpace))
	}
}


private struct ContentSizeViewModifier: ViewModifier {
	@Binding var size: CGSize
	func body(content: Content) -> some View {
		content
			.onGeometryChange(for: CGSize.self) { proxy in
				proxy.size
			} action: { newValue in
				self.size = newValue
			}
	}
}

private struct ContentFrameViewModifier: ViewModifier {
	@Binding var frame: CGRect
	var coordinateSpace: CoordinateSpace = .global
	
	func body(content: Content) -> some View {
		content
			.onGeometryChange(for: CGRect.self) { proxy in
				proxy.frame(in: coordinateSpace)
			} action: { newValue in
				self.frame = newValue
			}
	}
}
