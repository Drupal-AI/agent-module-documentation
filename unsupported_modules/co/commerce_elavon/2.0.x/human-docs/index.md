# Commerce Payment Elavon — manual setup guide

**Commerce Payment Elavon** (`commerce_elavon`) is a Drupal Commerce payment
gateway for **Elavon** — the Converge / Virtual Merchant payment service — so a
store can process card payments through Elavon. It offers an on‑site option
(sale, real‑time authorisation, capture including partial, and refund including
partial) and an off‑site redirect option for credit‑card transactions where no
card number passes through your web server. It depends on Drupal Commerce.

> **⚠️ This module is unsupported and its security coverage has been revoked.**
> The project is marked **Unsupported** on drupal.org because of a security issue
> the maintainer did not fix, and its security‑advisory coverage is **revoked**.
> That means it no longer receives security fixes from the Drupal Security Team.
> Before you use it, seriously consider the alternatives the project itself
> suggests: choose another, actively maintained payment gateway instead; follow
> the "unsupported project" process; or hire someone to fix the security bug so
> the module can be re‑published and supported. Do not deploy this to a live store
> handling real payments without addressing that.

If, with that caveat firmly in mind, you still need to set it up, the module works
like any Commerce gateway: nothing happens on enable alone — you add and configure
the gateway with your Elavon merchant credentials before it can take payments.
Store those credentials as secrets, operate over HTTPS, confirm the gateway's mode
(test vs live), and make sure the payment result is validated server‑side against
Elavon's authenticated API rather than trusting a client‑side result.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (read the unsupported‑module warning first).
2. [Configuration](configuration/index.md) — add the Elavon gateway and enter
   your merchant credentials securely.

## Where it lives in the admin menu

Commerce Payment Elavon has no settings page of its own. Like every Commerce
payment method, it is added under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) by adding a
gateway and choosing the Elavon plugin.
