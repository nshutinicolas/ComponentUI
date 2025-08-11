//
//  TextWithLink.swift
//  ComponentUI
//
//  Created by Musoni nshuti Nicolas on 11/08/2025.
//

import SwiftUI

public struct TextWithLink: View {
	public typealias TextLink = [String: String]
	let text: String
	let links: TextLink
	let highlightColor: Color
	let underlineStyle: Text.LineStyle
	
	public init(
		text: String,
		links: TextLink,
		highlightColor: Color = .blue,
		underlineStyle: Text.LineStyle = .single
	) {
		self.text = text
		self.links = links
		self.highlightColor = highlightColor
		self.underlineStyle = underlineStyle
	}
	
    public var body: some View {
		Text(makeAttributedString())
    }
	
	private func makeAttributedString() -> AttributedString {
		var attributed = AttributedString(text)
		
		for (key, value) in links {
			if let range = attributed.range(of: key) {
				attributed[range].foregroundColor = highlightColor
				attributed[range].underlineStyle = underlineStyle
				if let url = URL(string: value) {
					attributed[range].link = url
				}
			}
		}
		
		return attributed
	}
}

#Preview("Link text") {
	Group {
		TextWithLink(
			text: "By continuing, you agree to our Privacy Policy.",
			links: [
				"Privacy Policy.": "https://www.google.com",
				"By": "https://ibirori.com"
			]
		)
		Spacer()
			.frame(height: 20)
		TextWithLink(
			text: "By continuing, you agree to our Privacy Policy.",
			links: [
				"Privacy Policy.": "https://www.google.com",
				"By": "https://ibirori.com"
			],
			highlightColor: .gray,
			underlineStyle: .init(pattern: .dashDotDot, color: .red)
		)
	}
}
