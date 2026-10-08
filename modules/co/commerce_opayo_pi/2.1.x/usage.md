<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Opayo Pi provides a Drupal Commerce payment gateway for Opayo (formerly Sage Pay, now Elavon) built on the Opayo Pi REST API.

---
Opayo's Pi integration tokenizes card details in the shopper's browser so the Drupal back-end never handles the raw card number. This module wires that flow into Commerce: client-side JavaScript (an Opayo drop-in checkout or the module's own custom form) exchanges the card for a token using a merchant session key, the server creates the transaction via the `OpayoPi` service, and an optional 3D-Secure step — rendered in an iframe or as a standalone page — completes strong customer authentication before the payment is captured.

Generic credentials (vendor name, live/test integration keys and passwords, expired-record retention) are set at `/admin/commerce/config/opayo_pi/settings` under `administer opayo transactions`. Four checkout-flow routes are gated by `access content`: two mint short-lived merchant session keys for the browser JS and two handle the 3D-Secure redirect/result. These are public checkout-flow endpoints — the merchant session key is a public-flow token, not order-owner-sensitive data — and all are `no_cache: true`. A `Cron` handler with `queue_unique` reconciles and expires stored `opayo_transaction` entities. The module needs `commerce_payment`, `phone_international`, and `queue_unique`, and Opayo requires a customer phone number in international format.

Setup: set the Opayo credentials, add a Commerce payment gateway using the **Opayo (Pi integration)** plugin with billing collection enabled, attach the **Opayo checkout flow** (which adds the 3D Secure pane) to the relevant order types, and provide a customer phone field.
---
- Accept card payments through Opayo / Elavon in Commerce
- Tokenize cards in the browser so the server never sees the PAN
- Perform 3D Secure strong customer authentication at checkout
- Render the 3D Secure step inside an iframe
- Render the 3D Secure step as a standalone page
- Use Opayo's drop-in checkout widget
- Use the module's custom card form for more control
- Switch between Opayo live and test integration keys
- Configure the Opayo vendor name and passwords
- Mint merchant session keys for the client-side flow
- Collect billing information during checkout
- Require a customer phone number in international format
- Use a Phone International field for the phone number
- Reconcile transaction status via cron
- Expire and clean up old `opayo_transaction` records
- Set retention for expired transaction records
- Add the Opayo checkout flow with a 3D Secure pane
- Restrict transaction administration to a permission
- Log verbose gateway activity for debugging
- Handle the ACS redirect and result server-side
- Integrate Opayo payments with Commerce order types
- Support shipping information alongside Opayo payment
