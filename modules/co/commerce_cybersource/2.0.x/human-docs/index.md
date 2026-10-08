# Commerce CyberSource — manual setup guide

**Commerce CyberSource** (`commerce_cybersource`) integrates the **CyberSource**
payment gateway with Drupal Commerce. It supports two of CyberSource's payment
APIs: **Secure Acceptance Hosted Checkout (SAHC)**, an off‑site redirect flow, and
**Flex Microform v2**, an on‑site iframe flow. In both cases the customer's card
data is entered against CyberSource — not posted through your Drupal server —
which keeps card details out of your codebase and **reduces your PCI scope**.

CyberSource is a major payment provider, and setting it up requires matching
configuration on the CyberSource side (a live or sandbox account) as well as in
Drupal. The module's README documents account settings you must apply, and — for
SAHC specifically — a manual change to Drupal's default **SameSite cookie
attribute**, because the off‑site redirect return depends on it. Read the README
carefully before going live.

One implementation detail worth calling out: CyberSource's own PHP REST client
library has outdated dependencies that conflict with Drupal's, so this module uses
a **fork maintained by Centarro** until the upstream client is updated.

It depends on **Commerce Payment** (`commerce_payment`), **Commerce Order**
(`commerce_order`), and **Commerce Log** (`commerce_log`), and supports Drupal
10.3 and 11. (The `8.x-1.0` release is Drupal 10+ only; `8.x-1.0-beta7` was the
last Drupal 9 release.)

> **On the security side — good news.** This integration gets the two things
> right that payment gateways most often get wrong. Card data goes to CyberSource via SAHC/Flex (PCI scope reduced), and the
> **payment response signature is verified** — the module recomputes the
> HMAC‑SHA256 over the signed fields with your shared secret and **rejects** the
> response if the signature does not match, so a forged "payment accepted"
> response is turned away.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — add the CyberSource gateway, enter
   your credentials, and apply the required account and cookie settings.

## Where it lives in the admin menu

Like every Commerce gateway, CyberSource is added under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). The gateway's own form is where you
enter your CyberSource credentials and choose SAHC or Flex Microform.
