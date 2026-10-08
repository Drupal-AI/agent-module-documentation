# Commerce Signifyd — manual setup guide

**Commerce Signifyd** (`commerce_signifyd`) connects your Drupal Commerce store to
[Signifyd](https://www.signifyd.com/), the fraud-protection and chargeback-guarantee
service. When a customer places an order, the module opens a Signifyd "case", sends the
order and fulfillment data to Signifyd, and receives risk scores and decisions back
through signed webhooks. Based on what Signifyd reports, it can automatically move an
order through your configured workflow — approving low-risk orders and declining risky
ones — so your team spends less time reviewing orders by hand.

The module solves a specific problem: online stores get hit with fraudulent orders and
the chargebacks that follow. Signifyd scores each order and (on its guarantee plans)
takes on the chargeback liability. This module is the plumbing between the two — it
creates cases, ingests the results, and reacts to them. It needs configuration before it
does anything useful: you must add a Signifyd "team" with its API key, register a webhook
URL in the Signifyd dashboard, and choose which workflow transitions to fire.

It depends on Commerce plus `commerce_order`, `commerce_log`, and `commerce_payment`.
Two optional submodules extend it: **Device Fingerprint** (`device_fingerprint`) injects
Signifyd's device-fingerprinting script so Signifyd can identify the device behind an
order — most integrations will want this — and **User Order Data** (`user_order_data`)
adds aggregate account-age and order-history signals to each case (it needs Commerce
Exchanger to convert amounts to USD).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   pick the submodules you need.
2. [Configuration](configuration/index.md) — connect your Signifyd account, add a team,
   register the webhook, and wire up automatic order transitions.

## Where it lives in the admin menu

Once enabled, the module's global settings live at **Commerce → Configuration → Signifyd
settings** (`/admin/commerce/config/signifyd/settings`). You reach it with the **Access
Commerce administration pages** permission. Stored fraud cases are listed in the Signifyd
cases view. Signifyd teams (which hold the API keys) are managed as their own
configuration entities.
