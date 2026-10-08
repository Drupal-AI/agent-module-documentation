# Mollie for Drupal — manual setup guide

**Mollie for Drupal** (`mollie`) connects your Drupal site to the
[Mollie](https://www.mollie.com/) payment service provider so you can take real
online payments — iDEAL, credit cards, PayPal, Bancontact and the other local
methods Mollie supports (it is especially popular in the Netherlands and
Belgium). You bring a Mollie account; the module handles talking to Mollie's API
and recording the resulting payments in Drupal.

The project is built as a small base module plus three submodules, one for each
place a payment might happen. The base module holds the API client (it uses the
`mollie/mollie-api-php` PHP library, version `^2.52`) and a `mollie_payment`
entity that records each payment. On top of that: **Mollie for Drupal Commerce**
(`mollie_commerce`) plugs Mollie in as a Drupal Commerce payment gateway;
**Mollie for Drupal Webform** (`mollie_webform`) takes a payment as part of a
webform submission — the practical route for donations, event fees and
registrations where a full shop would be overkill; and **Customers API**
(`mollie_customers`) manages Mollie customer records for recurring or stored
payments.

This module needs configuration before it can do anything: at minimum you must
enter your Mollie **API key** on its settings page, and then wire up whichever
context (Commerce or Webform) you are using. The API key is a live financial
credential — this guide walks you through storing it safely rather than pasting
it into exported configuration. Both permissions the module defines
(`access mollie payments overview` and `administer mollie`) are marked as
access-restricted, which is correct because the payments overview lists real
financial records.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodule you need.
2. [Configuration](configuration/index.md) — enter the Mollie API key safely and
   understand the payment-confirmation webhook.

## Where it lives in the admin menu

Once enabled, the module's own configuration lives at **`/admin/mollie`**
(config route `mollie.configuration`). Drupal Commerce gateway settings live with
your other Commerce payment gateways; Webform payment settings live on the
individual webform's handlers.

## A note on the payment webhook

As with every payment integration, the webhook Mollie calls back to confirm a
payment is the security-critical path, and it must be treated as untrusted input.
The correct pattern — and the one the Mollie API client supports — is to
**re-fetch the payment status from Mollie** using the payment id rather than
trusting whatever the callback request body claims. If you are extending or
customising this integration, verify that confirmation path before you go live.
