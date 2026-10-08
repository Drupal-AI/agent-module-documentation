# Commerce PostFinance — manual setup guide

**Commerce PostFinance** (`commerce_postfinance_checkout`) adds a Drupal Commerce
payment gateway for the **PostFinance Checkout** API. PostFinance, part of Swiss
Post, is a major Swiss payment service provider. It is an *off-site* (redirect)
gateway: at checkout the shopper is sent to PostFinance's hosted payment page —
where they can pay with PostFinance Card, Visa, Mastercard, Twint, and any other
method activated in your PostFinance space — and then returned to the Commerce
order.

The problem it solves is accepting Swiss payments in Commerce while keeping card
handling entirely off-site (which reduces your PCI scope). Because it is off-site,
the final confirmation of payment arrives asynchronously through a **webhook** at
`/commerce_postfinance_checkout/webhook`, and the module updates the Commerce
payment from PostFinance's authoritative state.

It depends on Commerce's **Payment** and **Price** modules and supports Drupal
10.3 and 11. It does **not** work on enable alone: you must add a PostFinance
gateway with your space/user/API credentials and register the webhook URL in the
PostFinance portal. On the security side the module behaves correctly — the
webhook does not trust the inbound request body but re-fetches the transaction
from PostFinance's API before updating anything, so a forged notification cannot
mark an order paid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the PostFinance gateway, enter
   your credentials, and register the webhook.

## Where it lives in the admin menu

Commerce PostFinance adds no settings page of its own. You configure it as a
payment gateway under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`), where you add a new
gateway and choose the **PostFinance** plugin. See
[Configuration](configuration/index.md).

> **Note:** This module is marked *minimally maintained*. It is intended for
> merchants who hold a PostFinance contract; test against a PostFinance test space
> before going live.
