<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, controllers, ledger

## Services (`webform_booking.services.yml`)
| Service | Class | Role |
|---|---|---|
| `webform_booking.payment_settings` | `PaymentSettings` | Reads `webform_booking.settings`: `hasClientSecret()`, `environment()`, `currency()`, `decimals()`. |
| `webform_booking.booking_price` | `BookingPrice` | **Server-side price**: `expectedMinor($webform, $values)`, `valuesWithinLimits()`. The browser never sets the amount. |
| `webform_booking.slot_availability` | `SlotAvailability` | `valuesAvailable($webform, $values)` against existing bookings. |
| `webform_booking.paypal_client` | `Service\PayPalClient` | REST calls: `createOrder($minor,$currency)`, `getOrder()`, `captureOrder()`; token cached. Throws `PayPalException`. |
| `webform_booking.paypal_order_ledger` | `PayPalOrderLedger` | Table `webform_booking_paypal_order`: `recordCreated()`, `load()`, `markCaptured()`; statuses created/used. Atomic single-submission claim. |
| `webform_booking.payment_verification` | `PaymentVerification` | Ties price + settings + ledger to verify a payment. |
| `webform_booking.availability_access` | `Access\BookingAvailabilityAccessCheck` | `_webform_booking_availability` route check. |
| `webform_booking.paypal_payment_access` | `Access\PayPalPaymentAccessCheck` | `_webform_booking_paypal` route check. |
| (no tag) | `Access\CancelBookingAccessCheck` | Token/permission check for cancellation. |
| `webform_booking.translations` | `Service\WebformBookingTranslations` | UI string translations. |

## Controllers
- `Controller\WebformBookingController` — `getAvailableDays()`, `getAvailableSlots()` (JSON for the
  picker).
- `Controller\PayPalController` — `createOrder()` (ignores posted amount, recomputes via `BookingPrice`,
  checks limits + availability, flood-limits 20/IP/hr, records ledger), `captureOrder()` (re-verifies
  amount/availability, fetches remote order, captures, records once). Idempotent recovery if a capture
  completed at PayPal but the response was lost.

## Payment sequence (paid booking)
1. Browser POSTs booking values to `paypal/order` → server computes amount, creates PayPal order,
   ledgers it `created`, returns `{id}`.
2. Buyer approves in PayPal JS SDK → browser POSTs to `paypal/order/{order}/capture`.
3. Server re-checks amount + availability, verifies the remote order, captures, marks the ledger row
   captured, returns `{id, capture_id, status: COMPLETED}`. Submission then saves.
Capture happens before submission validation (documented window in the contrib `SECURITY.md`); a lost
last-seat race refuses the submission and leaves the order for retry/refund.

## Data / integration
- Table `webform_booking_paypal_order` (ledger), booking-slot storage on submissions.
- View `booking_submissions`; tokens in `webform_booking.tokens.inc` (booking date/time/slots).
- No Drush commands.
