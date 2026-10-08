# PayU Donations (payu_payments) — manual setup guide

**PayU Donations** (`payu_payments`) provides a configurable **"PayU Block"** that
renders a donation/payment form: a visitor enters an amount, and on submit an order
is created with PayU and the visitor is redirected to PayU to complete payment. It
is typically used to raise funds for a cause, and it is configured entirely on the
block itself — each block placement carries its own PayU merchant settings.

> **Heads up — this project is marked obsolete/unsupported.** The maintainers list
> it as no longer maintained. If you are starting a new site, consider the actively
> maintained **PayU Donations** (`payu_donations`) module instead, which adds
> signature-verified payment notifications. Use `payu_payments` only if you already
> depend on it.

Under the hood the block uses the official **OpenPayU PHP SDK** (`payu/openpayu`).
When the form is submitted it builds an order — description, customer IP, POS ID,
currency, and the amount — calls `OpenPayU_Order::create()`, and on success
redirects the visitor to PayU's payment page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (pulling in the
   OpenPayU library) and enable it.
2. [Configuration](configuration/index.md) — place the PayU block and enter your
   PayU merchant credentials.

## Where it lives in the admin menu

There is no central settings page. Everything is configured on the block, placed
through **Structure → Block layout** (`/admin/structure/block`). See
[Configuration](configuration/index.md).

## How payment confirmation works

This module is a **create-order-and-redirect** flow only — it has **no inbound PayU
notification (IPN) route** of its own. That means order fulfilment and payment
verification happen on **PayU's side**, not inside Drupal; the module never
receives a server-to-server callback to verify. The visitor-entered amount is
expected behaviour for a donation form. If you need Drupal to *record* and
*verify* completed payments with a signed notification, use the actively maintained
`payu_donations` module instead.
