# Commerce Chase — manual setup guide

**Commerce Chase** (`commerce_chase`) integrates **Chase Paymentech** card
processing with Drupal Commerce, letting your store charge cards through Chase's
**Orbital** payment gateway. It is the module to reach for when your merchant
account is with Chase and you want card payments handled through their processor.

The Drupal 8+ version provides an **onsite** payment gateway (plugin id
`chase_hpf`, "Orbital® Hosted Payment Form"). At checkout it embeds Chase's
**Hosted Payment Form** in an `<iframe>` served from Chase's own domain. The
customer types their card details into that hosted form, which **tokenizes** the
card and returns a token (a customer reference number) plus a masked card number —
so the raw card number and security code are entered on Chase's page and never
posted to your Drupal server. The gateway then uses Chase's **Orbital SOAP API** to
authorize, capture, and void charges and to manage stored card profiles.

To connect to Orbital you configure the gateway with your **Secure Account ID**,
**Orbital API username and password**, **Terminal ID**, **Merchant ID**, and
processing **BIN** (Stratus or PNS), and pick **test** or **live** mode. These
values come from your Chase Orbital account.

Because this is a card gateway, treat it with the usual care: run your checkout
over **HTTPS**, keep the credentials you enter out of any config you commit to
version control, restrict who can administer payment gateways, and make sure your
PCI-compliance posture matches how card data flows. See
[Configuration](configuration/index.md) for the setup details.

Commerce Chase depends on Commerce **Payment** (`commerce_payment`) and works on
Drupal 9.3, 10 and 11. The current release is an **alpha** and the project is
minimally maintained, so pin your version, test thoroughly, and don't assume
production readiness without your own verification. Chase Paymentech also requires
individual certification of merchants before you can use this integration in live
mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the Chase (Orbital) gateway,
   entering your Orbital credentials, and the HTTPS/PCI safeguards.

## Where it lives in the admin menu

Like every Commerce payment method, Chase is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
Orbital® Hosted Payment Form plugin.
