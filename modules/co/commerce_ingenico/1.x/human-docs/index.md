# Commerce Ingenico — manual setup guide

**Commerce Ingenico** (`commerce_ingenico`) integrates the **Ingenico ePayments**
gateway (formerly **Ogone**), one of the leading European payment solutions, with
Drupal Commerce. It registers **two** payment gateway plugins so you can choose how
customers pay:

- **Ingenico DirectLink** (`ingenico_directlink`, *on-site*) — the customer enters
  their card details on your merchant page, and the module calls Ingenico's
  DirectLink API. It can optionally tokenise cards via the Alias Gateway for repeat
  purchases (no card number is stored locally), and it supports 3-D Secure by
  handing off to the e-Commerce gateway when authentication is required.
- **Ingenico e-Commerce** (`ingenico_ecommerce`, *off-site*) — the customer is
  redirected to Ingenico's hosted payment page via a signed POST form and returned
  to your site afterwards.

Both gateways support **authorize-only then capture-later** transactions (useful
for avoiding refunds), voiding an authorization, capturing, refunding, and renewing
an expiring authorization — all from the order admin. There is an automated capture
process too, driven by cron.

Payment integrity rests on **SHA signatures**: outbound requests are signed with a
**SHA-IN** passphrase and inbound feedback is verified with a **SHA-OUT**
passphrase, using an algorithm (SHA-1, SHA-256 or SHA-512 — SHA-512 recommended)
that must match your Ingenico back office exactly. Both the browser return and the
server-to-server notification reject any response whose signature does not match,
and payment state is advanced only from the async notification — so the trust
boundary is sound. The module also supports white-label Ingenico clones (for
example BarclayCard/ePDQ) via custom base URLs, and multi-lingual hosted pages.

Installation requires two third-party PHP libraries, pulled in by Composer. It
depends on Commerce and Commerce Price and runs on Drupal 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its
   libraries) and enable the module.
2. [Configuration](configuration/index.md) — configure the Ingenico back office,
   add the gateway(s), and mirror the SHA passphrases.

## Where it lives in the admin menu

Like every Commerce gateway, the Ingenico gateways are added under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). The authorize-vs-capture transaction
mode is set on the checkout flow at **Commerce → Configuration → Checkout flows**.
See [Configuration](configuration/index.md).
