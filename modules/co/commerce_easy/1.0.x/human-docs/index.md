# Commerce Easy (Nets Easy) — manual setup guide

**Commerce Easy** (`commerce_easy`) is a Drupal Commerce payment gateway for
**Nets Easy** — the hosted checkout from Nexi that is widely used across the
Nordics and Europe. Shoppers pay through the Nets Easy flow, entering their
payment details in the Nets secure environment rather than on your server, which
keeps sensitive card data off your Drupal site and reduces your PCI compliance
scope.

Nets Easy supports cards (Visa, MasterCard, Dankort with auto‑save), pay‑later
and instalment invoices (AfterPay, Ratepay), PayPal, and mobile wallets such as
Vipps, Swish and MobilePay, so a single integration gives customers a range of
payment options. The module depends only on Drupal Commerce's **Payment** module
(`commerce_payment`).

Nothing happens on enable alone — you add and configure the gateway with your
Nets Easy credentials before it can take payments. As with any hosted gateway,
the trust boundary is the **payment confirmation**: the gateway should confirm
the payment status server‑side against the Nets API before your site treats an
order as paid, rather than trusting the shopper's return from the hosted page.
This is a development release, so review the confirmation flow for the version you
install before going live, and treat your Nets API keys as secrets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Nets Easy gateway and enter
   your credentials.

## Where it lives in the admin menu

Commerce Easy has no settings page of its own. Like every Commerce payment
method, it is added under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a gateway and
choosing the Nets Easy plugin.
