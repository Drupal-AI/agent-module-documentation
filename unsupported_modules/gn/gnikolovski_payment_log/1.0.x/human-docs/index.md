# Payment Log — manual setup guide

**Payment Log** (`gnikolovski_payment_log`) records **payment-gateway requests and
responses** so you have an audit trail of what your Drupal Commerce payment
gateways sent and received. It is a building block for other modules: a payment
gateway integration calls its `logRequest()` service, and Payment Log writes a row
capturing the customer's **email**, the **order ID**, the **gateway name**, the
request **time**, and an `additional_data` **JSON payload** of the gateway
request/response.

The stored rows are exposed for review through **Views**, so you build the actual
"payment log" screen as a view over the log data. Access to that data is gated by a
single **View payment logs** permission.

This module is primarily useful when you run Commerce and one of your payment
gateway modules integrates with it (for example the Banca Intesa gateway). It is a
logging and auditing aid — it does not process payments itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — you do not configure options.
Setup is about the permission and building a view, covered below.

## How to use it, and an important caution about what it stores

Once enabled and once a gateway is feeding it, log rows accumulate automatically.
To review them, create a **View** based on the payment-log data and place it on an
admin page.

Take the permission seriously, because of *what* the log holds. Each row can
contain **customer email (personal data)** and the **full gateway
request/response JSON** — transaction IDs, authorisation and response codes, and
whatever else the gateway passes. That means:

- Grant **View payment logs** only to **trusted finance/admin staff**. Go to
  **People → Permissions** and assign it deliberately.
- Make sure the gateway integrations feeding the log do **not** put raw card data
  (full card number / CVV) into `additional_data` — that would be a PCI compliance
  problem.
- **Prune** old log entries in line with your data-retention policy.
