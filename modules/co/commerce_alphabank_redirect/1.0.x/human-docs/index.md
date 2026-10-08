# Commerce Alphabank — manual setup guide

**Commerce Alphabank** (`commerce_alphabank_redirect`) is an off‑site **redirect**
payment gateway for **Alpha Bank (Greece)** in Drupal Commerce. With the
redirection method, your customers are sent to Alpha Bank's own hosted payment page
to enter their card details, and on return the module records the payment against
the order. A nice consequence of this design: no card data is stored on your
Drupal site, which improves security and lowers cost because you don't need payment
certificates on your own server.

It depends on Drupal Commerce and Commerce Payment (`commerce_payment`), and lives
in the Commerce package. The developers note they can build similar redirect
gateways for other banks on request.

The callback handling is sound and worth understanding, because it's what protects
you from a forged "paid" result. When Alpha Bank calls back, the module computes a
**SHA‑256 digest** over the response fields concatenated with your merchant
**shared secret** and rejects the callback if the received digest doesn't match —
so an attacker who doesn't know your secret cannot forge a payment. On a mismatch
it records a non‑fulfilling "Unvalidated" payment and logs a failure (Commerce only
treats *completed* payments as paid), and only a secret‑valid, captured/authorized
response creates a completed payment. The essential rule, therefore, is to keep
your **shared secret** genuinely secret — it is the whole basis of trust — and to
serve everything over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Alpha Bank gateway and enter
   your merchant ID and shared secret.

## Where it lives in the admin menu

Like every Commerce payment gateway, you add and configure it under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md) for the fields.
