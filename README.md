# SwiftUI Component UI

A collection of SwiftUI components customized to fit specific needs. Helps to reduce the dev time.

### Content Size

Previously we were stuck with `GeometryReader` and on it's own had drabacks. Luckly Apple gave us `onGeometryChange` modifier.

Previously we could use the preference key
```
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
}
```

**Now with componentUI**

```
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

> NOTE:
> Built this project in a learning environment, can't credit all my sources but the internet has been good to having all this live
