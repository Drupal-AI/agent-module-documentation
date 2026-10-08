# Commerce Payrexx integration — manual setup guide

**Commerce Payrexx integration** (`commerce_payrexx_integration`) adds a Drupal
Commerce payment gateway for **Payrexx**, a Swiss payment service provider that
accepts all the popular payment methods. It gives your store an *off-site*
(redirect) checkout: the shopper is sent to Payrexx to pay, and Payrexx reports
the result back to your site through a return URL and a webhook.

The problem it solves is a familiar one for anyone selling in Switzerland (or to
Swiss customers): you want to take card and local payments without handling card
data yourself, and Payrexx is a common choice. This module is the glue between
Payrexx and Commerce's checkout and payment system. It depends only on **Drupal
Commerce** and lives in the Commerce (contrib) package.

It does **not** work on enable alone — like every payment gateway it needs
configuring before it can take a payment. You add a Payrexx gateway and enter
your Payrexx instance name and API secret. One reassuring detail worth calling
out: the module handles payment results safely. When Payrexx calls its webhook,
the module treats the posted data as untrusted and **re-fetches the transaction
from Payrexx's authenticated API** before marking anything paid; the browser
return path is confirmed the same way, and the credentials you enter are checked
against Payrexx when you save the gateway. A forged webhook therefore cannot mark
an order paid — the authoritative status always comes from Payrexx.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Payrexx gateway and enter
   your credentials, field by field.

## Where it lives in the admin menu

Commerce Payrexx integration adds no settings page of its own. Like every
Commerce payment gateway, you configure it as a gateway under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). There you add a new gateway and
choose the **Payrexx (Redirect to Payrexx)** plugin. See
[Configuration](configuration/index.md) for the full walkthrough.
