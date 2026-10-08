# Commerce Monetico — manual setup guide

**Commerce Monetico** (`commerce_monetico`) is a Drupal Commerce payment gateway
for **Monetico** — the payment kit (Cybermut) used by the French banks **CIC** and
**Crédit Mutuel**. It lets a Commerce store accept card payments: the customer is
redirected to Monetico to pay and then returns, with the module processing the
return/notification and recording the payment.

Its confirmation handling is done correctly. The callback controller **verifies
the Monetico HMAC-SHA1 seal** — it recomputes the MAC over the returned fields and
only marks the payment successful (and advances the order) when the recomputed MAC
matches the one Monetico posted. A mismatching seal is rejected as "MAC-NOT-OK"
and is not processed. The security of this verification rests entirely on your
Monetico **security key** staying secret.

The module depends on Drupal Commerce's Payment module and targets **Drupal 9, 10,
and 11**. It is in **maintenance-fixes-only** status and is **seeking a
co-maintainer**. (For Drupal 7 sites, the separate Commerce CM-CIC module was the
equivalent.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Monetico gateway and enter
   your TPE number and security key.

## Where it lives in the admin menu

Commerce Monetico adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **Monetico**. Monetico calls your site back at
`/commerce_monetico/response`.
