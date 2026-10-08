# Commerce Barion Payment — manual setup guide

**Commerce Barion Payment** (`commerce_barion_payment`) adds a Drupal Commerce
payment gateway for **Barion**, a licensed European (Hungarian) payment
provider that serves customers across the EEA. The customer pays through Barion's
Smart Gateway flow, and your store records the resulting Commerce payment. It
depends on Commerce and Commerce Payment (`commerce`, `commerce_payment`).

What makes this gateway trustworthy is *how* it confirms a payment. When Barion
notifies your site (`onNotify`) it sends only a `paymentId`; the module does not
take the notification at face value. Instead it calls Barion's authenticated API
(`GetPaymentState`) with your merchant API key to fetch the real, authoritative
payment state, and acts on that. Because the status is fetched server‑to‑server
from Barion, a forged notification cannot mark an order as paid.

Setup is quick: install, enable, then add a Barion gateway and enter your API
credentials. Barion promotes the gateway as a conversion‑friendly checkout that
works on any device.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — add the Barion gateway and enter
   your API/POS keys and environment.

## Where it lives in the admin menu

Commerce Barion Payment adds no page of its own. You configure it as a gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — see
[Configuration](configuration/index.md).
