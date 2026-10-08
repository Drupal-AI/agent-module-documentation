<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Booking — agent index

A `webform_booking` Webform element that turns a form into a slot/appointment booking, with server-side
availability enforcement, optional server-verified PayPal payment, tokenised cancellation, and a calendar
view. Global settings at `/admin/config/services/webform-booking`. Depends on `webform` (^6).

- **Settings (PayPal/currency/country), the booking element config, endpoints, cancellation flow** →
  [configure/settings.md](configure/settings.md)
- **The `webform_booking` element plugin & availability model** → [plugins/booking_element.md](plugins/booking_element.md)
- **The three permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Services (PayPal client, ledger, price, availability), routes, tokens, View** → [api/services.md](api/services.md)

Submodules (own docs):
- `webform_booking_calendar` (FullCalendar block/feed) → [../../modules/webform_booking_calendar/1.2.x/agent/start.md](../../modules/webform_booking_calendar/1.2.x/agent/start.md)
- `webform_booking_price_element` (title+price element) → [../../modules/webform_booking_price_element/1.2.x/agent/start.md](../../modules/webform_booking_price_element/1.2.x/agent/start.md)

Key facts:
- Element `webform_booking` (`Plugin/WebformElement/WebformBooking`); availability via
  `SlotAvailability`/`SlotGrid`/`SlotDayFilter`.
- Availability endpoints `/get-days/...`, `/get-slots/...` = `access content` + `_webform_booking_availability`.
- PayPal endpoints `/webform-booking/{webform}/paypal/order[/{order}/capture]` = `access content` +
  `_webform_booking_paypal`; **amount computed server-side** (`BookingPrice`), captures verified and
  ledgered (`PayPalOrderLedger`, `PaymentVerification`), create-order flood-limited (20/IP/hr).
- Config `webform_booking.settings` (paypal_client_id/secret/environment, currency, default_country).
- The contrib dir ships its own `SECURITY.md` documenting known by-design tradeoffs.
