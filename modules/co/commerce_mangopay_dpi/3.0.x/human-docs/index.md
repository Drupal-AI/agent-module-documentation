# Commerce MANGOPAY Direct Pay-In — manual setup guide

**Commerce MANGOPAY Direct Pay-In** (`commerce_mangopay_dpi`) is an **on-site**
Drupal Commerce payment gateway for **MANGOPAY Direct Pay-Ins** — the customer
enters their card and pays **without leaving your site**. It supports card
registration (tokenization), **3-D Secure** ("secure mode") authentication, and
**Apple Pay**.

Because it is on-site, card details are collected in the checkout form and
**tokenized in the browser** by MANGOPAY's card-registration JavaScript kit, so
raw card (PAN) data never reaches your Drupal server. The module creates MANGOPAY
users and wallets automatically, pre-registers the card, handles the 3-D Secure
redirect, and completes the Direct Pay-In. The final payment status is read from
the server-side Commerce payment record and MANGOPAY's API — not from anything the
browser reports — which keeps the flow trustworthy.

This module deliberately covers **Direct Pay-Ins only** (enough to let customers
pay online); Transfers, Pay-Outs, and KYC are out of scope. It depends on Drupal
Commerce's Payment module, the **mangopay2-php-sdk** PHP library, and the
**cardregistration-js-kit** JavaScript library, which you download and place in
your libraries directory yourself (see Installation). This version targets
**Drupal 9 and 10**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   MANGOPAY JS kit, and enable the module.
2. [Configuration](configuration/index.md) — add the MANGOPAY gateway, enter your
   credentials, and choose the card / Apple Pay method types.

## Where it lives in the admin menu

Commerce MANGOPAY DPI adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **Mangopay**.
