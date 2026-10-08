<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CommerceGatewayHandler, reconciliation, store fields

## Service `commerce_epayco.handler` (`src/CommerceGatewayHandler.php`)

Extends the base `Drupal\epayco\GatewayHandler` and adds Commerce reconciliation. Constructor args:
`@http_client`, `@commerce_epayco.logger`, `@entity_type.manager`, `@commerce_payment.order_updater`. Interface
`CommerceGatewayHandlerInterface`.

- `checkPendingPayments(array $conf = []) : array` — queries `commerce_payment` where
  `payment_gateway LIKE 'epayco_%'` and `state = authorization` (range/offset from `$conf['limit']`, optional
  `remote_id` IN filter), then for each payment calls `getTransactionRemoteData($payment->remote_id)` and inspects
  the API's `data.x_cod_response`: `1` → set state `completed`; `2`/`4` → `authorization_voided`; saves. Sets
  `setRemoteState(x_response)`. When `$conf['save_order']` is truthy it re-runs `PaymentOrderUpdater::updateOrder()`
  for the affected orders. Returns a `stats.counters` summary.
- `loadMultiplePaymentsByRemoteId(array $remote_id) : array` — loads ePayco `commerce_payment` entities by
  `remote_id IN (...)`.

## Cron and Drush

- `commerce_epayco_cron()` calls `commerce_epayco.handler->checkPendingPayments(['save_order' => TRUE])`.
- Drush `commerce_epayco:check_pending_payments` (alias `epayco-check-pending-payments`,
  `src/Commands/DrushCommands.php`, `drush.services.yml`). Options: `--remote_id` (comma list), `--offset`,
  `--range`, `--save_order` (`yes`/`no`, default yes). Prints the total processed.

## Per-store credential fields (`commerce_epayco.module`)

`hook_entity_base_field_info` adds string base fields to `commerce_store`: `epayco_client_id`, `epayco_key`,
`epayco_api_public_key`, `epayco_api_private_key`, `epayco_language`, and boolean `epayco_mode`. When set, the
outbound checkout uses them instead of the factory values (standard checkout needs client id + key; one-page needs
public key + language). `hook_form_commerce_store_form_alter` groups these into "ePayco / Basic settings / API
settings" details; visibility is gated by `_commerce_epayco_check_access()`, which requires the
`commerce_epayco override gateway parameters` permission AND at least one ePayco gateway to exist.

## Hook

`hook_commerce_epayco_payment_data_alter(PaymentInterface $payment, array &$parameters)` (`commerce_epayco.api.php`)
— alter outbound checkout parameters before they are sent to ePayco.
