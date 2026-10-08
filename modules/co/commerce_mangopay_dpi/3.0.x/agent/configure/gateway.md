<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce MANGOPAY DPI — configure the gateway

## Prerequisites
- Enable `commerce_mangopay_dpi` (requires `commerce_payment`).
- Install the MANGOPAY **cardregistration-js-kit** into your libraries directory as
  `libraries/cardregistration-js-kit` (see README).
- Have MANGOPAY API credentials (client id / API key, sandbox or production).

## Gateway
Add a payment gateway using the `Mangopay` (on-site) plugin and enter your MANGOPAY credentials and
mode. Enable the `credit_card` and/or `apple_pay` payment method types as needed.

## Checkout endpoints (controller)
`src/Controller/MangopayController.php` provides the AJAX/callback routes (all `_access: 'TRUE'`
because they are needed during checkout):
- `preRegisterCard()` — creates the MANGOPAY user/wallet if missing and pre-registers the card.
- `processSecureMode($commerce_order, $commerce_payment)` — handles the 3-D Secure return.
- `validateApplePayMerchant()` / `preRegisterApplePay()` — Apple Pay session/registration.

The final payment state comes from the server-side `commerce_payment` entity and the MANGOPAY pay-in /
secure-mode status, not from client-supplied parameters. Card PAN data is tokenized in the browser via
the JS kit and does not reach the Drupal server.
