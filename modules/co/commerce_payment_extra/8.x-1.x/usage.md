<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Payment Extra adds a capture/void automation layer on top of Drupal Commerce payments.

---

The base module (`commerce_payment_extra`) is API-only: a `PaymentManager` service that resolves which of an
order's payments can be captured or voided, two events to override that resolution, and two Advanced Queue
job types (`commerce_payment_extra_capture`, `commerce_payment_extra_void`) that perform the action through
the payment gateway plugin. Its `commerce_payment_extra_order` submodule wires this into the order
lifecycle: capture payments when an order is completed, void them when it is canceled, and cron-auto-place
draft orders that are authorized in full but were never finished by the customer.

Payments still go through Commerce's normal payment handling and access control; capture/void amounts are
computed server-side from the order balance, and the real charge is delegated to the gateway. The only
admin surface is the submodule settings form at `/admin/commerce/config/payment/extra-order` (gated by the
*Administer payment gateways* permission); all automations are off by default. Queued jobs are processed via
`drush advancedqueue:queue:process commerce_payment_extra_order`.

---

- Resolve an order's capturable/voidable payments.
- Override that resolution via events.
- Capture a payment through its gateway.
- Void a payment through its gateway.
- Run capture/void as Advanced Queue jobs.
- Capture payments when an order completes.
- Void payments when an order is canceled.
- Auto-place fully-authorized abandoned orders.
- Configure automations per payment gateway.
- Cap captures at the order balance.
- Delegate the charge to the gateway plugin.
- Compute amounts server-side.
- Process the queue on cron.
- Provide a Drush place-authorized-orders command.
- Gate settings behind the payment-gateway admin permission.
- Build advanced payment automation.
- Extend Commerce payment handling.
- Synchronize payment status with order status.
- Use the PaymentManager service from custom code.
- Enable the order submodule for the automations.
