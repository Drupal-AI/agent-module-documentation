# Commerce Midtrans — manual setup guide

**Commerce Midtrans** (`commerce_midtrans`) integrates the **Midtrans** payment
gateway into Drupal Commerce's payment and checkout systems. Midtrans is a popular
payment platform in **Indonesia**, offering more than 16 payment channels —
credit card, bank transfer, convenience-store payments such as Alfamart, GoPay,
and more — so this module lets an Indonesian store accept a wide range of local
payment methods with automatic order validation.

At checkout, the shopper pays via Midtrans (using Midtrans's Snap flow) and
Midtrans posts a notification back to your site to confirm the outcome. The module
handles that confirmation safely: even though the notification route is publicly
reachable, the Midtrans SDK **re-fetches the authoritative transaction status
directly from Midtrans (server-side, using your server key)** rather than trusting
the posted data — so a forged notification cannot mark an unpaid order as paid.

A couple of things to know before you rely on it: this is a **community
(unofficial)** Midtrans module — an official "Midtrans Commerce" module also
exists — and it is **minimally maintained** (maintenance fixes only). It depends
on Drupal Commerce's Payment module and targets **Drupal 10 and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Midtrans gateway and enter
   your Midtrans keys.

## Where it lives in the admin menu

Commerce Midtrans adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **Midtrans**.
