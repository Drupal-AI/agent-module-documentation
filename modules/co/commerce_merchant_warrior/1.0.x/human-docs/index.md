# Commerce Merchant Warrior — manual setup guide

**Commerce Merchant Warrior** (`commerce_merchant_warrior`) integrates the
**Merchant Warrior** payment service into Drupal Commerce's payment and checkout
systems, giving your store a secure way to take card payments. It supports both a
standard Drupal-backend checkout and a **decoupled/headless** flow via REST
endpoints.

Card capture uses Merchant Warrior's **Payframe** — an iframe that tokenizes the
card details in the browser, so raw card (PAN) data never touches your Drupal
server. The module also supports Merchant Warrior's **Token Payments**, letting
you securely store a customer's card in the Merchant Warrior system and authorize
future payments from the Drupal backend without handling sensitive card data
directly. Behind the scenes it talks to Merchant Warrior's Direct API.

The integration is built on sound server-to-server verification: outbound API
requests are **signed with your API passphrase** (an md5 transaction hash for
transaction operations, and an HMAC-SHA256 message hash for card verification),
and cards are **verified server-side** through the Direct API rather than trusting anything the
browser reports — so payment outcomes come from authenticated API responses, not
a forgeable callback. It depends on Drupal Commerce, Commerce Payment, and core
**REST** (which powers the decoupled endpoints), and targets **Drupal 9.5, 10,
and 11**. You'll need a Merchant Warrior merchant account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Merchant Warrior gateway and
   enter your merchant credentials.

## Where it lives in the admin menu

Commerce Merchant Warrior adds no admin page of its own. Like every Commerce
payment gateway, you configure it under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway of type
**Merchant Warrior**.

For a **decoupled front end**, the module additionally exposes REST endpoints —
`/api/merchant-warrior/get-access-token` (returns an access token plus the Payframe
submit/src URLs) and `/api/merchant-warrior/process-authorization` (authorizes a
payment from a Payframe token) — so a separate front end can drive the Payframe
and place the order. Most stores using the standard Drupal checkout won't need to
touch these directly.
