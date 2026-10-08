# NoFraud — manual setup guide

**NoFraud** (`nofraud`) connects your Drupal Commerce store to the
[NoFraud](https://www.nofraud.com/) fraud‑screening service. When an order is
placed, the module sends the relevant order and payment details to NoFraud's API,
which scores the transaction for fraud so risky orders can be flagged or held. It
can also cancel a transaction through the API and keeps a record of every NoFraud
transaction in a custom entity you can review at
`/admin/commerce/config/nofraud/list`.

It plugs into Drupal Commerce and depends on **Commerce Payment**
(`commerce_payment`) — this is a checkout add‑on, not a standalone tool. A webhook
endpoint (`/webhook/nofraud/update-status`) lets NoFraud push status updates back
to the stored transaction records.

The module does **not** work on enable alone: you must supply a valid **NoFraud
API key** and choose a mode (Sandbox for testing, Production for live orders)
before any screening happens. Because it transmits **order and customer/payment
details (PII)** to an external service, treat it as a trusted integration: send
over HTTPS, store the API key as a secret rather than in plain config, and
disclose the data sharing in your privacy policy. Use Sandbox mode until you are
confident the flow is correct — do not send real transactions to NoFraud's
production API during testing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   confirm Commerce Payment is present.
2. [Configuration](configuration/index.md) — enter the API key securely, pick a
   mode, and enable debug logging.

## Where it lives in the admin menu

Once enabled, the settings form sits under Commerce at
**Commerce → Configuration → NoFraud** (`/admin/commerce/config/nofraud`), and the
list of recorded NoFraud transactions is at `/admin/commerce/config/nofraud/list`.
