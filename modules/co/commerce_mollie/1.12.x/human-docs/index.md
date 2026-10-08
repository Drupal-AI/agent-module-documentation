# Commerce Mollie — manual setup guide

**Commerce Mollie** (`commerce_mollie`) adds [Mollie](https://www.mollie.com/) as a
payment gateway for Drupal Commerce. It uses the official Mollie PHP SDK and works
as an **off-site redirect** gateway: at checkout the shopper is sent to Mollie to
pay (iDEAL, cards, and Mollie's other methods), and afterwards Mollie calls a
webhook back to your site that re-fetches the authoritative payment status and
moves the Commerce order along.

That webhook design is the important security feature: the module never trusts the
status in the incoming request body. When Mollie notifies your site, the module
looks up the local payment and then re-queries Mollie's API for the real status
before capturing, voiding, or expiring the payment. A forged or replayed webhook
therefore cannot spoof an order into the "paid" state.

Because it authenticates to Mollie, the gateway needs your Mollie **API keys** (a
test key and a live key). Treat those keys as secrets — set them per environment
via an environment variable or `settings.php` override rather than committing them
to exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Mollie SDK) and enable the module.
2. [Configuration](configuration/index.md) — add and set up the Mollie payment
   gateway, field by field.

## Where it lives in the admin menu

The module has no settings page of its own — Mollie is configured like any other
Commerce gateway at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
