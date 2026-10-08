<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Payment Extra — agent index

Adds a small **capture/void automation layer** on top of Drupal Commerce payments. The base module
(`commerce_payment_extra`) is API-only: a `PaymentManager` service that resolves which of an order's
payments are **capturable** or **voidable**, two filter events to override that resolution, and two
**Advanced Queue** job types that actually capture/void a payment via its gateway plugin. The
`commerce_payment_extra_order` submodule wires those into the order lifecycle: capture on completion,
void on cancellation, and a cron/Drush job that auto-places fully-authorized draft orders whose customer
never returned to finish checkout.

There are **no customer-facing routes**. The only route is the submodule admin settings form, gated by the
restricted `administer commerce_payment_gateway` permission. Capture/void amounts are computed server-side
from the order balance; the real charge is delegated to the gateway plugin, which enforces its own auth.

Version **8.x-1.0-rc5**. Core `^10 || ^11`. Base module deps: `commerce:commerce_payment` (info.yml) plus
`drupal/advancedqueue` and `drupal/commerce` (composer, needed for the queue job types).

- **Base API — `PaymentManager` service, filter events, default gateway-capability filter, the
  `commerce_payment_extra_capture` / `commerce_payment_extra_void` Advanced Queue job types** →
  [api.md](api.md)
- **`commerce_payment_extra_order` submodule — settings form + config keys, capture-on-fulfill /
  void-on-cancel subscribers, `enable_cron` auto-place manager, the Drush command, the queue** →
  [order.md](order.md)

Key facts:
- Service `commerce_payment_extra.manager` (`PaymentManager`): `loadCapturablePaymentsByOrder(OrderInterface)`
  and `loadVoidablePaymentsByOrder(OrderInterface)` — load all of the order's `commerce_payment` entities,
  dispatch a filter event, return the survivors.
- Events (`PaymentExtraEvents`): `commerce_payment_extra.filter_capturable_payments` and
  `commerce_payment_extra.filter_voidable_payments`; event objects expose `getPayments()/setPayments()/getOrder()`.
- Default subscriber (`FilterPaymentsSubscriber`, priority **-200**) keeps only payments whose gateway plugin
  implements `SupportsAuthorizationsInterface` + `canCapturePayment()` (capturable) or
  `SupportsVoidsInterface` + `canVoidPayment()` (voidable).
- Job types (both `max_retries: 10`, `retry_delay: 3600`s): `commerce_payment_extra_capture` (payload
  `payment_id`, optional `amount`; missing amount = full payment amount) and `commerce_payment_extra_void`
  (payload `payment_id`). Both no-op-fail if the gateway lacks the capability; gateway exceptions become
  `JobResult::failure`.
- Submodule config `commerce_payment_extra_order.settings`: `enable_cron` (bool),
  `authorized_auto_place_min_threshold` (default 3600s), `authorized_auto_place_max_threshold`
  (default 2592000s), `supported_payment_gateways` (array of gateway ids), `capture_payments_on_order_transition`
  (bool), `cancel_payments_on_order_transition` (bool). All automations default OFF on a fresh install.
- Submodule triggers: `commerce_order.fulfill.post_transition` → queue captures up to the order balance;
  `commerce_order.cancel.post_transition` → queue voids; `hook_cron` → auto-place authorized draft orders.
- Submodule config route: `commerce_payment_extra_order.settings` at `/admin/commerce/config/payment/extra-order`
  (permission `administer commerce_payment_gateway`). Drush: `commerce-payment-extra-order:place-authorized-orders`
  (alias `cpeo:pao`). Advanced Queue queue id: `commerce_payment_extra_order` (database backend, daemon processor).
- Queue processing is manual/cron: `drush advancedqueue:queue:process commerce_payment_extra_order`.
