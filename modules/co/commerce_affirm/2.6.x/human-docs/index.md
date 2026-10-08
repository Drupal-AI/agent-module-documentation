# Commerce Affirm — manual setup guide

**Commerce Affirm** (`commerce_affirm`) integrates **Affirm** point‑of‑sale
consumer financing into Drupal Commerce, so shoppers can buy now and pay over time
with a fixed monthly plan (a "buy‑now, pay‑later" option). At checkout the customer
chooses Affirm, is taken through Affirm's financing flow, and your store captures
the resulting charge — letting people order immediately on credit from Affirm.

Beyond the checkout gateway, the module provides **blocks** you can place anywhere
to advertise Affirm's offering. On product pages, the Affirm messaging block uses
the product price to show the theoretical monthly payment, which is a proven way to
lift conversion on higher‑priced items.

It depends on Commerce Payment (`commerce_payment`), has a settings form at
`commerce_affirm.settings`, and lives in the Commerce (contrib) package. You'll
need an Affirm **sandbox** account for testing and a **production** account to go
live.

Because this moves money, mind a few security essentials. Store your Affirm
**public and private API keys as secrets** — keep them out of exported
configuration and version control — and serve everything over HTTPS. The
integration uses Affirm's **server‑side authorization and capture**: your Drupal
server confirms and captures the charge against Affirm's authenticated API (using
the private key and the checkout token Affirm returns) rather than trusting a
client‑side "success". Always confirm the gateway is in the correct **mode**
(sandbox vs live) before and after go‑live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Affirm settings form and the
   payment gateway: API keys, sandbox/live mode, and the advertising blocks.

## Where it lives in the admin menu

- **Module settings:** the Affirm settings (`commerce_affirm.settings`) under
  **Commerce → Configuration**.
- **Payment gateway:** added under **Commerce → Configuration → Payment
  gateways** (`/admin/commerce/config/payment-gateways`).
- **Advertising blocks:** placed via **Structure → Block layout**
  (`/admin/structure/block`).
