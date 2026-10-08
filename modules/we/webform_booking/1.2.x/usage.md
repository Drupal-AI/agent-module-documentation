<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Booking adds a `webform_booking` element that turns a Webform into a slot/appointment booking form: visitors pick an available day and time slot, availability is enforced server-side, and an optional PayPal integration takes (server-verified) payment before the submission is accepted. Bookings can be cancelled via a tokenised link and viewed on a calendar.

---

The core deliverable is the `webform_booking` Webform element (`Plugin/WebformElement/WebformBooking`,
render element `Element/WebformBooking`) configured per-webform with slot definitions; supporting classes
`SlotAvailability`, `SlotGrid`, `SlotDayFilter`, `BookingValue` compute and validate availability against
existing submissions. Two AJAX endpoints, `/get-days/{webform}/{element}/{date}` and
`/get-slots/...` (controller `WebformBookingController`), feed the picker; both require `access content`
plus a custom `_webform_booking_availability` check that the named webform is open and actually holds a
booking element (they deliberately expose only free/occupied slots, by design, since the form needs them).
Booking payments use PayPal: `Controller/PayPalController` creates and captures orders via
`Service/PayPalClient`, with the **amount always computed server-side** (`BookingPrice`), a
`PayPalOrderLedger` that claims each order atomically against one submission, and `PaymentVerification`;
the endpoints are gated by `access content` + `_webform_booking_paypal` (allowed only when the form is
open, takes payment, and a client secret is configured), and create-order is flood-limited per IP.
Bookings can be cancelled at `/webform_booking/{webform}/submissions/{submission}/cancel_booking` via a
per-submission token (`CancelBookingConfirmForm`, access `CancelBookingAccessCheck`). Global settings
(PayPal client id/secret/environment, currency, default country) live at
`/admin/config/services/webform-booking` (route `webform_booking.settings`, permission
`manage webform booking`, restricted). The module ships a `booking_submissions` View, booking tokens
(`webform_booking.tokens.inc`), and two submodules: `webform_booking_calendar` (a FullCalendar block/feed
of bookings) and `webform_booking_price_element` (a title+price Webform element). The module's own
`SECURITY.md` documents the query-string cancel token, the by-design availability disclosure, and the
move to server-side PayPal verification.

---

- Add an appointment/slot booking picker to a Webform.
- Let visitors choose an available day, then an available time slot.
- Prevent double-booking by enforcing slot availability server-side.
- Show remaining availability live as the visitor picks a date (AJAX).
- Take PayPal payment for a booking before accepting the submission.
- Compute the charge server-side so the browser cannot tamper with the amount.
- Verify PayPal captures server-side and record them in a ledger.
- Claim each PayPal order atomically against a single submission to prevent replay.
- Flood-limit payment attempts per IP.
- Let a customer cancel their own booking via a tokenised link (no account needed).
- Let staff cancel any booking with the restricted `cancel all webform bookings` permission.
- Set the PayPal environment (sandbox/live), currency, and default country.
- Display bookings on a FullCalendar calendar via the calendar submodule.
- Provide a per-day/per-slot booking availability feed to a calendar block.
- Add a titled price line item to a booking form via the price-element submodule.
- Review booking submissions through the provided View.
- Use booking tokens in confirmation emails (date, time, number of slots).
- Restrict who can view the raw Webform Booking input field (`view webform booking input`).
- Build a multi-service booking form combining booking + price elements.
- Offer free bookings (no PayPal) simply by not configuring a client secret.
- Localise booking UI strings via the translations service.
- Reconcile PayPal statements against the `webform_booking_paypal_order` ledger.
