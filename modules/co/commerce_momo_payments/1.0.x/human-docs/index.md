# Commerce MoMo Payments — manual setup guide

**Commerce MoMo Payments** (`commerce_momo_payments`) integrates the **MoMo**
payment platform (Vietnam) into Drupal Commerce. It adds three offsite payment
types to the Commerce payment system — **MoMo Wallet**, **MoMo ATM**, and **MoMo
Credit Card** — each redirecting the buyer to MoMo to pay and then handling the
return and the IPN (server-to-server) notification when they come back.

All three gateways share a common base that signs the outbound "create payment"
request with your MoMo **secret key** and verifies the **HMAC-SHA256 signature**
on both the return and the IPN callback before recording a payment. A successful,
correctly signed result records a Commerce payment for the order.

The module depends on Drupal Commerce and Commerce Payment, targets **Drupal 9.2
and 10**, and is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a MoMo gateway, enter your
   partner/access/secret keys.

## Where it lives in the admin menu

Commerce MoMo Payments adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **MoMo Wallet**, **MoMo Pay with ATM**, or **MoMo Credit
Card**.
