<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, endpoints, cancellation

## Global settings form
Route `webform_booking.settings`, path `/admin/config/services/webform-booking`, form
`Form\WebformBookingSettingsForm`, permission `manage webform booking` (`restrict access: true`).
Config `webform_booking.settings` (schema `config/schema/webform_booking.schema.yml`):
| Key | Meaning |
|---|---|
| `paypal_client_id` | PayPal REST client id. |
| `paypal_client_secret` | PayPal REST secret (payment is inactive while empty → forms are free). |
| `paypal_environment` | `sandbox` or `live`. |
| `currency` | ISO currency code for charges. |
| `default_country` | Default country for the booking form. |
Read through `PaymentSettings` (`hasClientSecret()`, `environment()`, `currency()`, `decimals()`).

## The booking element
Add a **Booking** element (`webform_booking`) to a webform (Webform UI → Add element → category
"Booking"). Slot/day configuration is stored on the element; see
[../plugins/booking_element.md](../plugins/booking_element.md).

## Availability endpoints (AJAX, used by the picker)
| Route | Path | Access |
|---|---|---|
| `webform_booking.get_days` | `/get-days/{webform_id}/{element_id}/{date}` | `access content` + `_webform_booking_availability` |
| `webform_booking.get_slots` | `/get-slots/{webform_id}/{element_id}/{date}` | same |
`BookingAvailabilityAccessCheck` returns 403 unless the webform is open and `element_id` is a
`webform_booking` element. Occupancy is intentionally readable by anyone who can load the form.

## PayPal endpoints
| Route | Path (POST) | Access |
|---|---|---|
| `webform_booking.paypal_create_order` | `/webform-booking/{webform}/paypal/order` | `access content` + `_webform_booking_paypal` |
| `webform_booking.paypal_capture_order` | `/webform-booking/{webform}/paypal/order/{order}/capture` | same |
`PayPalPaymentAccessCheck` allows only when a client secret is configured, the webform is open, and it
has payment enabled. The **posted amount is ignored**; `BookingPrice::expectedMinor()` recomputes it,
availability is re-checked, the remote order status/amount is verified, and the capture is recorded once
in `PayPalOrderLedger`. Create-order is flood-limited (20/IP/hour).

## Cancellation
Route `webform_booking.cancel_booking_confirm` =
`/webform_booking/{webform}/submissions/{webform_submission}/cancel_booking`, form
`CancelBookingConfirmForm`, custom access `CancelBookingAccessCheck::checkCancelBookingAccess`. A
per-submission token (query string) authorises cancelling that one booking; the restricted
`cancel all webform bookings` permission bypasses the token. See the contrib `SECURITY.md` for the
maintainer's notes on carrying the token in the URL.

## Other config
- View `booking_submissions` (`config/install/views.view.booking_submissions.yml`).
- Tokens: `webform_booking.tokens.inc` (booking date/time/slot tokens for emails).
