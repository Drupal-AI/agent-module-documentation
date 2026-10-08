# Commerce Wallee — manual setup guide

**Commerce Wallee** (`commerce_wallee`) is a payment gateway that lets Drupal
Commerce accept payments through the **Wallee** platform (<https://wallee.com/>).
It uses Wallee's official PHP SDK (`wallee/sdk`), which Composer installs
automatically when you require the module, and it follows Wallee's offsite
checkout flow.

The problem it solves: rather than integrating Wallee's API by hand, you get a
ready‑made Commerce gateway plus a bundled **wstack** submodule that provides the
shared SDK and webhook layer. It depends on **Commerce** (`commerce`) and
Commerce **Payment** (`commerce_payment`).

Its webhook handling is built the right way: when Wallee calls back, the endpoint
reads only a remote **entity id + space id** from the payload, matches the
configured gateway by space id, and then **re‑fetches the authoritative object
from Wallee's API via the SDK** rather than trusting any status in the payload —
and it only acts on entities that already exist locally. So a forged webhook can
at most trigger a re‑sync to the transaction's real state; it cannot spoof a
payment status. Two operational notes worth knowing: the webhook route is
effectively public and unsigned (safe here only because state is re‑fetched), and
its Transaction branch contains a deliberate `sleep(20)`, so you should apply
rate‑limiting or worker limits so a public request cannot tie up a worker.

The gateway does **not** work on enable — you must add and configure a Wallee
gateway with your Wallee credentials (Space ID, User ID, and Secret). This is an
early Commerce 3 release; verify the flow for your version.

> **Upgrading from Commerce 2 (module 2.x)?** Version 3 has significant
> architectural changes. You **must uninstall and reinstall** the module:
> back up your Space ID / User ID / Secret, run `drush pmu commerce_wallee`,
> `drush cr`, then `drush en commerce_wallee`, reconfigure the gateway, and
> update the webhook URL in the Wallee backend. Payment tokens are **not**
> migrated automatically — migrate them manually in the plugin configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the Wallee SDK), enable the module and its `wstack` submodule.
2. [Configuration](configuration/index.md) — add the Wallee gateway, enter your
   credentials, and set up the webhook.

## Where it lives in the admin menu

Commerce Wallee adds no top‑level admin page. As a Commerce payment gateway you
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`), choosing **Wallee** as
the plugin. See [Configuration](configuration/index.md).
