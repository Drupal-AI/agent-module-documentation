# BeGateway Payment — manual setup guide

**BeGateway Payment** (`commerce_begateway`) adds a Drupal Commerce **off‑site
redirect** payment gateway for the **BeGateway** platform (used by a range of
payment service providers). The shopper is redirected to BeGateway to pay, then
returned to your site, and the order is completed on the return/notification. It
depends on Commerce Payment and the **Token** module, and declares support for
Drupal 8, 9, 10, and 11 (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

The gateway confirms payments safely. Its notification handler (`onNotify`) uses
the BeGateway SDK's `Webhook` object and checks `$webhook->isAuthorized()` — a
credential (shop‑id/secret) verification — **before** acting on the
notification, and the return path compares the gateway transaction amount against
the order's amount. In other words it does not blindly trust an incoming callback,
so a forged or mismatched notification cannot complete an order.

Setup is the usual Commerce gateway flow: install, enable, add a BeGateway
gateway, and enter your shop credentials. Keep those credentials backed by
environment variables rather than committed to config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — add the BeGateway gateway and enter
   your shop id and secret key.

## Where it lives in the admin menu

BeGateway Payment adds no page of its own. You configure it as a gateway under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — see
[Configuration](configuration/index.md).
