# Commerce Monobank — manual setup guide

**Commerce Monobank** (`commerce_monobank`) adds a Drupal Commerce payment method
for **Monobank** acquiring, the payment service widely used in **Ukraine**. It
embeds Monobank's payment flow into checkout: the module creates a Monobank
invoice, stores the invoice ID against the order, and uses that ID to look up the
payment's real status.

Confirmation follows the **authoritative** pattern: rather than trusting an
unverified callback, the module queries Monobank's **server-side status API**
(`api/merchant/invoice/status`) with your merchant token to confirm the invoice's
true state before completing the payment. It supports a **Test/Live** switch that
works automatically once set.

A few things to note before relying on it. This is an **alpha release**
(`8.x-1.0-alpha5`), so verify the flow carefully for your version. It is **not
covered by Drupal's security advisory policy**. And importantly, this release
stores the Monobank **X-Token in module configuration** rather than via the Key
module — see the [Configuration](configuration/index.md) page for how to handle
that safely. The module depends on Drupal Commerce's Payment module (Commerce
Core) and targets **Drupal 8 through 11**. It is maintained by Ukrainian
developers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register acquiring, add the Monobank
   gateway, enter your X-Token, and handle it safely.

## Where it lives in the admin menu

Commerce Monobank adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **Monobank**.
