<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce MANGOPAY Direct Pay-In is an on-site payment gateway that tokenizes cards through MANGOPAY's card-registration kit and processes Direct Pay-Ins, including 3-D Secure "secure mode" and Apple Pay.
---
The gateway plugin (`src/Plugin/Commerce/PaymentGateway/Mangopay.php`) creates MANGOPAY users/wallets and Direct Pay-Ins via the mangopay2-php-sdk, while a `MangopayController` (`src/Controller/MangopayController.php`) backs the AJAX steps used during checkout: pre-registering a card, processing 3-D Secure secure-mode redirects, validating an Apple Pay merchant session, and pre-registering Apple Pay. Payment method types `CreditCard` and `ApplePay` and the on-site `PaymentMethodAddForm` collect and tokenize card data client-side (JS in `js/register-card.js`, `apple-pay.js`, `method-check.js`) so raw PAN data does not transit the Drupal server.

The controller routes carry `_access: 'TRUE'` because they are the tokenization/3DS callback endpoints that must be reachable during checkout; the payment outcome is read from the server-side `commerce_payment` entity and the MANGOPAY API (secure-mode / pay-in status), not from client-supplied success flags. Requires the `cardregistration-js-kit` library in the libraries directory and MANGOPAY API credentials on the gateway. Setup: install the JS kit, add a MANGOPAY gateway with credentials, and configure allowed card/Apple Pay method types.
---
- Accept card payments on-site via MANGOPAY Direct Pay-In.
- Tokenize cards with the MANGOPAY card-registration kit.
- Support 3-D Secure (secure mode) redirects.
- Offer Apple Pay as a payment method.
- Create MANGOPAY users and wallets automatically.
- Pre-register a card before the pay-in.
- Validate an Apple Pay merchant session.
- Keep raw card data off the Drupal server.
- Read payment status from the server-side payment entity.
- Configure MANGOPAY API credentials per gateway.
- Add credit-card and Apple Pay method types.
- Integrate with the Commerce on-site checkout flow.
- Handle hard declines via SDK exceptions.
- Process secure-mode return for a specific order/payment.
- Require the cardregistration-js-kit library.
- Provide AJAX endpoints for card/Apple Pay registration.
- Complete pay-ins against a MANGOPAY wallet.
- Style the payment method add form.
- Deploy for EU MANGOPAY merchant accounts.
- Support customer stored cards.
