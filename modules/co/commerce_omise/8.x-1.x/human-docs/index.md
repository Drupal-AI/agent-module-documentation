# Commerce Omise — manual setup guide

**Commerce Omise** (`commerce_omise`) integrates the **Omise** payment gateway —
widely used in **Thailand and Japan** — with Drupal Commerce. The shopper pays via
Omise, and Omise posts a webhook event back to your store to report the outcome. It
depends only on Commerce **Payment** (`commerce_payment`).

The problem it solves is accepting Omise card payments in a Commerce store. You add
a Commerce payment gateway of type **Omise**, enter your Omise API credentials, and
choose test or live mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Omise payment gateway, enter
   your credentials.

## Where it lives in the admin menu

Omise is a payment gateway, so you set it up under **Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) → **Add payment
gateway** → choose the **Omise** plugin.
