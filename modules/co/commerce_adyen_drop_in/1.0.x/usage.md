<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Adyen Drop-in

Integrates Drupal Commerce with Adyen using the modern Adyen Drop-in / Sessions flow, creating payments from HMAC-verified Adyen notifications.

- Provides an off-site-style payment gateway backed by Adyen's JavaScript Drop-in component.
- Uses Adyen Checkout Sessions to authorise payments and Adyen webhooks to finalise them.
- Verifies each webhook notification's HMAC signature before recording a payment.
- Supports refunds through the Adyen Checkout API.

---

## Installation & configuration

- Requires `commerce` and `commerce_payment`, plus the Adyen PHP API library (`Adyen\Client`) via Composer.
- Add a payment gateway of type "Adyen Drop-In" in Commerce.
- Configure API key, client key, HMAC key, merchant account, live endpoint prefix and timeout.
- Set up the AUTHORISATION webhook in the Adyen dashboard pointing at the gateway's notify URL.
- Billing information is required by the gateway (`requires_billing_information = TRUE`).

---

## Usage & API

- `DropIn::setUpAdyenSession()` creates an Adyen session with amount, currency and billing/shopper data.
- Amounts are converted to minor units via a built-in currency exponent map.
- `onReturn()` re-fetches the session status from Adyen (`/sessions/{id}`) and never trusts the browser result alone.
- Only `completed`/`paymentPending` session statuses proceed; canceled/expired throw exceptions.
- `onNotify()` decodes the JSON `notificationItems` and validates each with Adyen's `HmacSignature::isValidNotificationHMAC()`.
- Notifications failing HMAC validation are logged and skipped (no payment created).
- Only `AUTHORISATION` events with `success == true` create a payment.
- The order is loaded from the signed `merchantReference`; the amount comes from the signed notification.
- Duplicate completed payments for the same `pspReference` are detected and skipped.
- `refundPayment()` calls the Adyen refunds endpoint and tracks partial/full refund state.
- The Adyen client uses the configured API key over HTTPS with default TLS verification.
- Payment finalisation deliberately waits for the webhook, per Adyen's recommended flow.
- The Drop-in component is rendered client-side via the attached `commerce_adyen_drop_in/drop_in` library.
- Shopper reference is user UUID (authenticated) or order UUID (anonymous) to avoid collisions.
- Test vs live is controlled by the gateway mode and live endpoint prefix.
- Security posture: webhook is HMAC-verified and bound to order + amount from the signed payload.
