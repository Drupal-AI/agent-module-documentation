# Bitaps Payment — manual setup guide

**Bitaps Payment** (`bitaps`) is a cryptocurrency payment gateway that plugs into the
contributed **Basket** commerce module, taking payments through the Bitaps service.
It lets a Basket-powered store accept crypto (such as Bitcoin) checkout without a full
Commerce stack.

Once configured, it presents a hosted payment page to customers, records each payment
in its own database table, and listens for status callbacks from Bitaps. When Bitaps
reports a confirmed payment, the module updates the payment record and tells Basket to
complete the order. It offers Bitaps as a Basket payment plugin, so it appears
alongside your other Basket payment methods.

The gateway is configured with Bitaps credentials, including a **secret key** used to
verify callbacks. As with any payment integration, that secret is sensitive — keep it
confidential. **Please read the security notes below and in
[Configuration](configuration/index.md) before using this module in production:** a
security review of this version recorded findings on how the payment callback is
verified.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it works with the Basket commerce module).
2. [Configuration](configuration/index.md) — enter the Bitaps credentials, expose
   the payment method in Basket, and review the security caveats.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Bitaps**
(`/admin/config/development/bitaps`), gated by the `access bitaps settings`
permission. The module also serves a customer payment page and a Bitaps status
callback under the `/bitaps/...` path.

## How to use it

1. Install the Basket commerce module and this module (see
   [Installation](installation/index.md)).
2. Enter your Bitaps credentials and currency, and expose the Bitaps payment method in
   Basket (see [Configuration](configuration/index.md)).
3. Customers then pay via the hosted Bitaps payment page, and confirmed payments mark
   the corresponding Basket order complete.

## Before taking real payments

Because this module handles money, keep the Bitaps secret key confidential, serve the
site over HTTPS, and test the full checkout flow against Bitaps' sandbox before going
live. See the [Configuration](configuration/index.md) operating notes and the
maintainers' project page for the current release status.
