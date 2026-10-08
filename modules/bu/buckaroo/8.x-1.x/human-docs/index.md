# Buckaroo for Drupal — manual setup guide

**Buckaroo for Drupal** (`buckaroo`) integrates the Buckaroo payment service — a
Netherlands/EU payment provider — so your site can take online payments. It uses
Buckaroo's official PHP SDK (`buckaroo/sdk`) under the hood, records each
transaction as a `buckaroo_payment` entity, and gives you an admin overview of
payments plus a credentials configuration form. An iDEAL payment method ships in
the box, and the design allows for additional Buckaroo methods.

A submodule, **Buckaroo Webforms** (`buckaroo_webforms`), adds a Webform
handler: attach it to a webform and a submission can trigger a Buckaroo payment,
with the amount taken from a form element you choose. The customer is redirected
to Buckaroo's hosted payment page to pay.

Payment status is **not** taken from an inbound gateway callback. Instead, on
each cron run the module asks the Buckaroo API — over an authenticated SDK
connection — for the current status of every pending transaction and updates the
local records accordingly. That means there is no unauthenticated "payment
succeeded" URL an attacker could forge.

**This is a payment integration, so treat its credentials as highly sensitive
(PCI).** You configure a Buckaroo **website key** and **secret key** and a
test/live mode. Keep the secret key out of public version control and use test
mode until you have verified the flow end to end — see
[Configuration](configuration/index.md).

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (pulls the
   Buckaroo SDK) and enable the module.
2. [Configuration](configuration/index.md) — enter your Buckaroo credentials,
   choose test/live mode, and optionally add the Webform payment handler.

## Where it lives in the admin menu

- **Credentials:** **Configuration → Web services → Buckaroo**
  (`/admin/config/services/buckaroo`), behind the restricted
  `administer buckaroo integration` permission.
- **Payments overview:** `/admin/buckaroo/payments`, behind the restricted
  `buckaroo integration payments overview` permission.
