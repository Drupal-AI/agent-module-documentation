<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CardPointe (commerce_cardpointe) — agent index

A **Drupal Commerce on-site payment gateway** for **CardPointe** (CardConnect / Clover Connect /
Fiserv). Cards are tokenized client-side in CardConnect's **hosted iframe tokenizer** (`itoke`), the
resulting `mytoken` is charged server-side via the **CardConnect Gateway REST API**, and an optional
**integrated terminal** path drives a **Clover Flex** device for card-present transactions via the
CardConnect **Terminal API**. Package `Commerce (contrib)`. Core `^10.3 || ^11 || ^12`. Requires PHP
`^8.1` and `drupal/commerce ^3`. License GPL-2.0-or-later. Installed **2.0.2** (version dir `2.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (`.info.yml`).
- Composer: **`drupal/commerce ^3`**, **`php ^8.1`** (`composer.json`). No third-party PHP libraries;
  API calls use the core `http_client` (Guzzle).

## What it provides (from source)

- **One payment gateway plugin** `cardpointe_hostediframe` — `Plugin/Commerce/PaymentGateway/HostedIframe`
  (extends `OnsitePaymentGatewayBase`), label "CardPointe (Hosted iFrame Tokenizer)". Modes `uat`
  (Sandbox) / `production`. Handles `createPayment`, `capturePayment`, `voidPayment`, `refundPayment`,
  `createPaymentMethod`, `deletePaymentMethod`. Serves **two payment method types**: `credit_card`
  (hosted iframe, online) and `cardpointe_credit_card_terminal` (Clover Flex, card-present).
- **Two payment method types**: core `credit_card`, plus `cardpointe_credit_card_terminal`
  (`Plugin/Commerce/PaymentMethodType/TerminalCreditCard`, extends core `CreditCard`, adds
  `cardpointe_terminal_card_*` fields).
- **Two API service classes**: `commerce_cardpointe.gateway_api` (`GatewayApi`) — CardConnect Gateway
  REST (`/cardconnect/rest/{auth,capture,void,refund,inquire,inquireMerchant}`), Basic-auth; and
  `commerce_cardpointe.integrated_terminal_api` (`IntegratedTerminalApi`) — CardConnect Terminal API
  (`connect`/`ping`/`authCard`/`disconnect`/`listTerminals`/…), API-key auth + session key.
- **Add-payment-method form** `PluginForm/HostedIframe/PaymentMethodAddForm` — renders the hosted
  tokenizer iframe (`credit_card`) or the terminal Authorize/Disconnect AJAX controls
  (`cardpointe_credit_card_terminal`).
- **Terminal config entity** `commerce_cardpointe_terminal` (`Entity/Terminal`) with full admin UI:
  list builder, add/delete/refresh forms, `TerminalStorage`, `TerminalAccessControlHandler`,
  `Access/TerminalViewAccessCheck`, two validation constraints (unique name, unique HSN), a bundled
  View, and templates. Routes under `/admin/commerce/config/payment-gateways/manage/{gateway}/terminals`.
- **JS** `js/hosted-iframe.js` (library `commerce_cardpointe/hosted-iframe`) — postMessage bridge to the
  tokenizer iframe with **origin validation**; writes `mytoken` + expiry into hidden fields.
- **Hooks** (`.module`): alters the checkout flow to add a **CVV field** for stored-card reuse
  (`cardpointe_card_code` → private tempstore → sent as `cvv2`), hides terminal payment options on the
  public checkout flow, `hook_entity_operation` (Terminals link), theme + preprocess.
- **Permission** (`.permissions.yml`): `manage commerce_cardpointe terminals` (restricted). Plus the
  `commerce_cardpointe_terminal` entity's own `view own commerce_cardpointe` etc.
- **Config schema** for the gateway plugin settings; **install/update** hooks install the terminal
  entity + payment-method bundle fields.

## Solution docs

- **Hosted-iframe gateway, GatewayApi, charge/capture/void/refund/payment-method flow, config form** →
  [payment-gateway.md](payment-gateway.md)
- **Integrated terminal: entity + admin UI, Terminal API, connect/auth/disconnect session flow** →
  [terminal.md](terminal.md)

## Security posture (positive facts)

- **Amount is server-side**: every charge/capture/refund amount comes from the Commerce
  `Payment`/`Order` object (`$payment->getAmount()`, `$order->getBalance()`), never from a request
  parameter — the client cannot set the price.
- **Card data is tokenized client-side**: the PAN is entered in CardConnect's hosted iframe and only a
  `mytoken` reaches the server; the stored payment method keeps only card type, **last 4**, and expiry.
- **TLS on**: API calls go through the core Guzzle `http_client` with default certificate verification;
  no `verify => false`.
