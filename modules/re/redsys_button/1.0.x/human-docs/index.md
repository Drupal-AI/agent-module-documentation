# Redsys Button to Drupal — manual setup guide

**Redsys Button to Drupal** (`redsys_button`, version 1.0.x) integrates the
**Redsys** payment gateway — the bank TPV widely used in Spain — with Drupal. It
presents a *pay with Redsys* button/form that redirects the customer to the Redsys
hosted payment page, so your site never collects card credentials directly. When
the customer finishes, Redsys sends the result back to your site.

The base module can take standalone payments and ships a **`commerce_redsys_button`**
submodule for sites running Drupal Commerce. It's a good fit for donations,
invoice payments, fees, and other one‑off payments.

**Security posture (why it matters for a payment gateway).** This version signs
the merchant request with **HMAC‑SHA256** — the standard Redsys signature scheme,
computed via a 3DES‑derived key — and ships a *Validators* component that checks
the signature on the payment notification/return. That signature check is what
stops an attacker from forging a "paid" callback. When you set this module up:

- Store the **merchant secret key** as a secret — keep it out of exported
  configuration and version control.
- Serve the site over **HTTPS** in production.
- **Confirm** that the notification/return path is signature‑validated in your
  configuration, so forged "paid" callbacks are rejected.

See [Configuration](configuration/index.md) for how to handle the credentials and
secret safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, optionally, the Commerce submodule).
2. [Configuration](configuration/index.md) — enter the Redsys merchant
   credentials, store the secret safely, and confirm callback verification.

## Where it lives in the admin menu

Its settings form is at the route `redsys_button.redsys_config_form`
(**Configuration → System → Redsys settings**, `/admin/config/system/redsys-settings`).
For Commerce, gateways are configured under **Commerce → Configuration → Payment
gateways** once the `commerce_redsys_button` submodule is enabled.
