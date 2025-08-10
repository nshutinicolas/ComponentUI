//
//  CalendarPopover.swift
//  ComponentUI
//
//  Created by Musoni nshuti Nicolas on 09/08/2025.
//

// Note: This is only available for iOS and iPad
#if canImport(UIKit)
import SwiftUI

extension View {
	/// Calendar Popover presented in a popover. The usage of DatePicker doesn't give much freedom on how to style the button that will present the date picker
	/// This View Modifier allows you to style the triggering button however you want.
	/// - Parameters:
	///  - displayedComponents: `DatePickerComponents`
	///  - isPresented: `Bool`
	///  - selected: Date to update incase of any changes
	///  - dateRange: Open Date range from a specific point. This does not accept a closed range or upto range, only from a specific date
	/// - Returns: ViewBuilder
	@ViewBuilder
	public func calendarPopover(
		for displayedComponent: DatePickerComponents,
		isPresented: Binding<Bool>,
		selected: Binding<Date>,
		/// Using `PartialRangeFrom` since I only need the users to set notification from now onward.
		in dateRange: PartialRangeFrom<Date> = Date.now...,
		arrowDirection: UIPopoverArrowDirection = .up
	) -> some View {
		self.nativePopover(isPresented: isPresented, arrowDirection: arrowDirection) {
			CalendarPopover(display: displayedComponent, selected: selected, in: dateRange)
		}
	}
}

struct CalendarPopover: View {
	let displayedComponent: DatePickerComponents
	@Binding var selected: Date
	let dateRange: PartialRangeFrom<Date>
	
	init(display: DatePickerComponents, selected: Binding<Date>, in dateRange: PartialRangeFrom<Date>) {
		self.displayedComponent = display
		self._selected = selected
		self.dateRange = dateRange
	}
	
	var body: some View {
		DatePicker("", selection: $selected, in: dateRange, displayedComponents: displayedComponent)
			.applyPickerStyle(for: displayedComponent)
			.labelsHidden()
	}
}

private extension View {
	/// Applies a graphical style for date-only pickers and a wheel style for time pickers.
	/// This is done specifically to match the intended design
	/// - Parameter components: `DatePickerComponents`
	/// - Returns ViewBuilder
	@ViewBuilder
	func applyPickerStyle(for components: DatePickerComponents) -> some View {
		if components == .date {
			self.datePickerStyle(.graphical)
		} else {
			self.datePickerStyle(.wheel)
		}
	}
}

#Preview("Date Time Picker Popover") {
	Group {
		CalendarPopover(display: .date, selected: .constant(.now), in: Date.now...)
		CalendarPopover(display: .hourAndMinute, selected: .constant(.now), in: Date.distantPast...)
	}
}
#endif
