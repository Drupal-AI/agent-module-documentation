# Commerce EuPlatesc Payment Gateway — manual setup guide

**Commerce EuPlatesc** (`commerce_euplatesc`) integrates **EuPlatesc.ro**, a
Romanian payment processor, into Drupal Commerce as an off‑site payment gateway.
At checkout the shopper is redirected to EuPlatesc's secure 3‑D Secure page to
enter card details (Visa, MasterCard, Maestro) and is returned to your site
afterwards. Every request and response is protected with **HMAC‑MD5 signature
verification**, so both the browser return and the server‑to‑server notification
(IPN) are validated before your site trusts the result.

It depends on Drupal Commerce and its **Payment** module (`commerce`,
`commerce_payment`). Nothing happens on enable alone — you add and configure an
*EuPlatesc Checkout* gateway with your merchant id and secret key, and set the IPN
URL inside your EuPlatesc merchant account. The module dispatches
`payment_success` / `payment_failure` events so other modules can react to
outcomes, and its payment processing is idempotent, so duplicate IPN deliveries
are handled safely.

Security here is thorough and worth trusting: each outbound request carries an
HMAC‑MD5 fingerprint, a fresh timestamp and a random nonce; the amount comes from
the order, not from client‑supplied form values; and on return/notify the module
recomputes the fingerprint (compared with `hash_equals()`) **and** asserts that
the signed invoice id, gateway and amount/currency all match the order — so a valid
signature can't be replayed against a different order or amount. Note the module is
not currently covered by a Drupal security advisory, but the reviewed signing and
verification logic is sound.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the EuPlatesc Checkout gateway,
   enter merchant id and secret key, and set the IPN URL.

## Where it lives in the admin menu

Commerce EuPlatesc has no settings page of its own. Like every Commerce payment
method, it is added under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a gateway and
choosing the **EuPlatesc Checkout** plugin.
