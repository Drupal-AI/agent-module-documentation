<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce ePayco (commerce_epayco) — agent index

Drupal Commerce integration submodule of **ePayco**: two off-site payment gateway plugins plus per-store overrides,
a pending-payment reconciler, and an outbound-data hook. Package `ePayco`. Core `^8.7.7 || ^9 || ^10 || ^11`.
GPL-2.0-or-later. Version-dir 2.0.x (`^2.0@dev` checkout). Depends on `commerce:commerce_payment`,
`commerce:commerce_order`, `epayco:epayco`.

## What it provides

- **Payment gateway plugins** (`src/Plugin/Commerce/PaymentGateway/`):
  - `epayco_standard_checkout` — `StandardCheckout` (redirect to ePayco secure checkout).
  - `epayco_onepage_checkout` — `OnePageCheckout` (on-page modal/iframe; `auto_open` setting).
  - Both extend `OffsiteCheckoutBase` (`OffsitePaymentGatewayBase`), form
    `Drupal\commerce_epayco\PluginForm\OffsiteRedirect\{Standard,OnePage}CheckoutForm`.
  See [plugins/gateways.md](plugins/gateways.md).
- **Service `commerce_epayco.handler`** (`CommerceGatewayHandler` extends base `GatewayHandler`) —
  `checkPendingPayments()` / `loadMultiplePaymentsByRemoteId()`. Plus `commerce_epayco.logger`. See
  [api/handler.md](api/handler.md).
- **Drush command** `commerce_epayco:check_pending_payments` (alias `epayco-check-pending-payments`) —
  `src/Commands/DrushCommands.php`.
- **Hooks** (`commerce_epayco.module`): `hook_entity_base_field_info` adds per-store ePayco fields to
  `commerce_store`; `hook_form_commerce_store_form_alter` groups them (access-gated); `hook_cron` reconciles
  pending payments; alter hook `hook_commerce_epayco_payment_data_alter($payment, &$parameters)`
  (`commerce_epayco.api.php`).
- **Config schema** `config/schema/commerce_epayco.schema.yml` — gateway config (`factory`, `auto_open`).
- **Permission** `commerce_epayco override gateway parameters` (restrict access).

## Solution docs

- [plugins/gateways.md](plugins/gateways.md) — the two gateways, outbound checkout build, and return handling.
- [api/handler.md](api/handler.md) — reconciler service, cron, Drush, per-store fields.
