# Commerce Viva Wallet — manual setup guide

**Commerce Viva Wallet** (`commerce_vivawallet`) provides a payment gateway for
**Viva Wallet** (Viva.com) in Drupal Commerce, accepting card payments through
Viva's smart‑checkout platform. It depends on **Commerce** and **Commerce
Payment**.

At checkout the customer pays through Viva's smart checkout, and Viva confirms the
result to your site with a **webhook**. The module also exposes the standard Viva
**webhook‑verification** (`verify_hook`) endpoint that returns Viva's verification
key during setup — this is normal and expected by Viva.

**On security (reviewed as sound):** the webhook payload carries only a
**transaction id**. Rather than trusting the payload for the payment status, the
controller **re‑fetches the transaction from Viva's API** (using your gateway
credentials) and sets the payment state based on that authoritative transaction. A
forged webhook therefore can't mark an order paid, because the fetched transaction
wouldn't be genuine or completed. Keep your Viva **client credentials** as secrets
and serve the site over HTTPS. The module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Viva Wallet payment gateway,
   enter credentials securely, and set up the webhook.

## Where it lives in the admin menu

Viva Wallet is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
