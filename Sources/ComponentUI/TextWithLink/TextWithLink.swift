//
//  TextWithLink.swift
//  ComponentUI
//
//  Created by Musoni nshuti Nicolas on 11/08/2025.
//

import SwiftUI

public struct TextWithLink: View {
	let text: String
	let linkText: String
	let url: String
	let highlightColor: Color
	let underlineStyle: Text.LineStyle
	
	public init(
		text: String,
		linkText: String,
		url: String,
		highlightColor: Color = .blue,
		underlineStyle: Text.LineStyle = .single
	) {
		self.text = text
		self.linkText = linkText
		self.url = url
		self.highlightColor = highlightColor
		self.underlineStyle = underlineStyle
	}
	
    public var body: some View {
		Text(makeAttributedString())
    }
	
	private func makeAttributedString() -> AttributedString {
		var attributed = AttributedString(text)
		
		if let range = attributed.range(of: linkText) {
			attributed[range].foregroundColor = highlightColor
			attributed[range].underlineStyle = underlineStyle
			if let url = URL(string: url) {
				attributed[range].link = url
			}
		}
		
		return attributed
	}
}

#Preview("Link text") {
	Group {
		TextWithLink(
			text: "By continuing, you agree to our Privacy Policy.",
			linkText: "Privacy Policy.",
			url: "https://www.google.com"
		)
		Spacer()
			.frame(height: 20)
		TextWithLink(text: "By continuing, you agree to our Privacy Policy.", linkText: "Privacy Policy.", url: "https://www.google.com", highlightColor: .gray, underlineStyle: .init(pattern: .dashDotDot, color: .red))
	}
}
