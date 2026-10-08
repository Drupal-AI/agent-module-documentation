<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco (epayco) — agent index

Base module for integrating the **ePayco** payment provider with Drupal, usable with or without Drupal Commerce.
Package `ePayco`. Core `^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version-dir 2.0.x (installed as a
`^2.0@dev` checkout). Depends on core `system` and the `epayco/epayco-php` SDK (Composer).

## What it provides

- **Config entity `epayco_factory`** (`src/Entity/Factory.php`) — a named set of ePayco account settings
  (client id, key, API public/private keys, language, test mode). Managed at
  `/admin/config/services/epayco/factory` (`configure`). See [config/factory.md](config/factory.md).
- **Service `epayco.handler`** (`Drupal\epayco\GatewayHandler`) — wraps the ePayco PHP SDK plus REST endpoints:
  transaction lookup, reference lookup, PSE bank list, and outbound checkout signature. See
  [api/gateway-handler.md](api/gateway-handler.md).
- **Service `epayco.payment_options.handler`** (`PaymentOptionsHandler`) — builds standalone ePayco payment
  buttons (no Commerce needed). See [events/transaction-response.md](events/transaction-response.md).
- **Route `epayco.transaction.default_response`** (`/epayco/transaction/response`) + theme
  `epayco__transaction_response` — the returning-customer landing page; dispatches the transaction event.
- **Event** `GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` (`epayco.transaction.response`) +
  `GatewayTransactionEvent`. See [events/transaction-response.md](events/transaction-response.md).
- **DataType plugin `epayco_factory`** (`src/Plugin/DataType/Factory.php`) wrapping an `\Epayco\Epayco` client.
- **Hook** `hook_theme` (two themes), `hook_help`. Libraries: external ePayco checkout JS + a payment-option
  behavior/style.

## Permissions (`epayco.permissions.yml`)

- `administer epayco factory` (restrict access) — manage factory config entities.
- `access epayco transaction response` — view the transaction-response page.

## Submodules (own doc trees under `../modules/`)

- `commerce_epayco` — Drupal Commerce off-site / on-page payment gateways.
- `epayco_api` — POST endpoint to run ePayco SDK operations.
- `epayco_business_rules` — Business Rules integration.

## Solution docs

- [config/factory.md](config/factory.md) — the `epayco_factory` config entity, its schema, forms and routes.
- [api/gateway-handler.md](api/gateway-handler.md) — the `epayco.handler` service methods and REST endpoints.
- [events/transaction-response.md](events/transaction-response.md) — response page, transaction event, payment buttons.
