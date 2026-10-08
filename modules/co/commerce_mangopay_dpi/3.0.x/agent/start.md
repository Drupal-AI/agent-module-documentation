<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce MANGOPAY Direct Pay-In (commerce_mangopay_dpi) — agent index
**On-site Commerce gateway for MANGOPAY Direct Pay-In: card tokenization, 3-D Secure, Apple Pay.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10
- **Depends on:** `commerce:commerce_payment`; needs the `cardregistration-js-kit` JS library + mangopay2-php-sdk.
- **Gateway:** `Mangopay` on-site plugin; method types `CreditCard`, `ApplePay`; on-site form `PaymentMethodAddForm`.
- **Routes (`_access: 'TRUE'`):** `preregister_card`, `process_secure_mode/{commerce_order}/{commerce_payment}`, `validate_apple_pay_merchant`, `preregister_apple_pay` — the tokenization/3DS callbacks used during checkout.
- **Security (reviewed — SOUND):** the anonymous-looking routes are the card-registration/3DS/Apple-Pay callbacks that must be reachable at checkout; payment outcome is read from the server-side `commerce_payment` entity and the MANGOPAY API, not from client success flags. Card data is tokenized client-side. No client-set amount, no unverified fulfilment.

See [configure/gateway.md](configure/gateway.md)
