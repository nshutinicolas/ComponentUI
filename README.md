# SwiftUI Component UI

A collection of SwiftUI components customized to fit specific needs. Helps to reduce the dev time.

### Content Size

Previously we were stuck with `GeometryReader` and on it's own had drabacks. Luckily, Apple gave us `onGeometryChange` modifier.

Previously we could use the preference key
```swift
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
struct SomeView: View {
    @State private var size: CGSize = .zero
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: 300, height: 300)
                .background {
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometry.size)
                }
                .onPreferenceChange(SizePreferenceKey.self) { newSize in
                    self.viewSize = newSize
                }
        }
    }
}
```

**Now with ComponentUI**

```swift
import ComponentUI

struct SomeView: View {
    @State private var size: CGSize = .zero
    var body: some View {
        Rectangle()
            .frame(width: 300, height: 300)
            .size($size) // <--😎
    }
}
```

### Popover/tooltip

The native SwiftUI Popover for iOS looks like a sheet which is different from the UIKit version.
This component reuses UIKit `UIPopoverPresentationController` in swiftUI.

Usage
```swift
import ComponentUI

struct SomeView: View {
	@State private var isPresented = false
	
	var body: some View {
		Button("Popover/Tooltip") {
			isPresented.toggle()
		}
		.nativePopover($isPresented) {
			ActualPopoverDesignView()
		}
	}
}
```

### Calendar Popover

In SwiftUI, we use `DatePicker` and the drawback is in design as we are forced to have the triggering UI/button/label look like apple recomends(ie: there is no room to style the triggering UI as you want)
This component allows you to have the calendar in a popover or tooltip style while giving you room to style your triggering button/label as you wish.

Usage
```swift
import ComponentUI

struct SomeView: View {
@State private var isPresented = false
@State private var selectedDate: Date = .now

	var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			Text("Style it as you wish")
		}
		.calendarPopover(for: .date, isPresented: $isPresented, selected: $selectedDate)
	}
}
```
> Note: this component is still limited in selecting the date range. But will be updated soon to allow all the range expressions

### TextWithLink

Displays a string where specified substrings are styled as tappable hyperlinks. The links open in `Safari`, so when linking a url, make sure it is compatible/readable in Safari.

> This is useful for creating legal disclaimers, terms & conditions notices, or any text where only part of the text should be interactive.

Usage:
```swift
import ComponentUI
struct SomeView: View {
	var body: some View {
		TextWithLink(
			text: "By continuing, you agree to our Privacy Policy.",
			links: [
				"Privacy Policy.": "https://www.ibirori.rw"
			],
			highlightColor: .pink,
			underlineStyle: .single
		)
	}
}
```

> NOTE:
> Built this project in a learning environment, can't credit all my sources but the internet has been good to having all this live
