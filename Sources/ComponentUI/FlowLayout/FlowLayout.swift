//
//  FlowLayout.swift
//  ComponentUI
//
//  Created by Musoni nshuti Nicolas on 17/08/2025.
//
// Source: https://www.swiftuifieldguide.com/layout/layout/

import SwiftUI

/// A custom layout that arranges views horizontally and wraps them to the next line
/// when there isn't enough horizontal space.
///
/// `FlowLayout` works similarly to a `HStack` that wraps to the next row,
/// making it ideal for tag lists, keyword chips, categories, or variable-width buttons.
struct FlowLayout: Layout {
	private let spacing: CGFloat
	
	/// - Parameter spacing: CGFloat with default value of `8`
	@inlinable
	init(spacing: CGFloat = 8) {
		self.spacing = spacing
	}
	
	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		let containerWidth = proposal.width ?? .infinity
		let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
		return layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth).size
	}
	
	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		let sizes = subviews.map { $0.sizeThatFits(.infinity) }
		let offsets = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width).offsets
		for (offset, subview) in zip(offsets, subviews) {
			subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
		}
	}
	
	private func layout(sizes: [CGSize], spacing: CGFloat = 8, containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
		var result: [CGPoint] = []
		var currentPosition: CGPoint = .zero
		var lineHeight: CGFloat = 0
		var maxX: CGFloat = 0
		for size in sizes {
			if currentPosition.x + size.width > containerWidth {
				currentPosition.x = 0
				currentPosition.y += lineHeight + spacing
				lineHeight = 0
			}
			result.append(currentPosition)
			currentPosition.x += size.width
			maxX = max(maxX, currentPosition.x)
			currentPosition.x += spacing
			lineHeight = max(lineHeight, size.height)
		}
		return (result, CGSize(width: maxX, height: currentPosition.y + lineHeight))
	}
}

#Preview {
	VStack(alignment: .leading)  {
		AnyLayout(FlowLayout(spacing: 4)) {
			ForEach(["First", "Second", "Third", "Fourth", "small", "Very long text to consider"], id: \.self) { text in
				Text(text)
					.font(.title2)
					.padding(6)
					.padding(.horizontal, 8)
					.background(Capsule().fill(.red))
			}
		}
		HStack(alignment: .bottom) {
			FlowLayout() {
				Rectangle()
					.frame(width: 100, height: 100)
				Rectangle()
					.frame(width: 80, height: 80)
				Rectangle()
					.frame(width: 120, height: 120)
				Rectangle()
					.frame(width: 150, height: 150)
				Rectangle()
					.frame(width: 100, height: 100)
				Rectangle()
					.frame(width: 100, height: 100)
			}
		}
	}
	.frame(maxWidth: .infinity, alignment: .leading)
}

