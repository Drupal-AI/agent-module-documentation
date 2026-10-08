<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Saferpay (commerce_saferpay) — agent index

Drupal Commerce **off-site payment gateway** for Saferpay (Six Payment Services / Worldline),
using Saferpay's **JSON API PaymentPage** hosted-redirect flow. Depends on
`commerce:commerce_payment`. Core `^8 || ^9 || ^10 || ^11`. Composer requires
`drupal/commerce:^2.11 || ^3`. No custom routes, services, permissions, hooks_install, or
templates — everything is delivered through Commerce's payment-gateway plugin system.

## What it provides

- **One payment gateway plugin** `saferpay_paymentpage` (label "Saferpay PaymentPage"),
  class `Drupal\commerce_saferpay\Plugin\Commerce\PaymentGateway\Saferpay`, extending
  `OffsitePaymentGatewayBase` and implementing `SupportsAuthorizationsInterface` +
  `SupportsRefundsInterface`. Payment method type `credit_card`.
- **One offsite plugin form** `SaferpayPaymentPageForm` (`src/PluginForm/`) that initializes the
  PaymentPage and builds the auto-submit redirect (`REDIRECT_GET`) to Saferpay's hosted page.
- **One exception** `SaferpayException` (`src/Exception/`) wrapping Saferpay HTTP 402 error bodies;
  constant `TRANSACTION_ABORTED` distinguishes shopper-abort from real failures.
- **Config schema** for the gateway plugin (`config/schema/commerce_saferpay.schema.yml`).
- **Two hooks** (`commerce_saferpay.api.php`): `hook_commerce_saferpay_assert_result` and
  `hook_commerce_saferpay_payment_page_data_alter`.

## Routes

No routes of its own. It reuses Commerce's generic gateway routes: the return handler
(`onReturn`) and the async notify handler (`onNotify`, route `commerce_payment.notify`). There is
**no dedicated settings page** — the gateway is created/edited on Commerce's Payment gateways admin
`/admin/commerce/config/payment-gateways` (permission `administer commerce payment gateway`).

## Subdocs

- **Gateway plugin: config keys, checkout/assert flow, capture/void/refund, API client** →
  [plugins/payment-gateway.md](plugins/payment-gateway.md)
- **Extension hooks (alter payment-page data, act on assert result)** →
  [api/hooks.md](api/hooks.md)

**Limitation:** real transactions need a Saferpay contract, live credentials, and outbound HTTPS to
`www.saferpay.com` / `test.saferpay.com`. In a sandbox you can create and introspect the gateway
**config entity** (plugin id + `mode` + credentials) but cannot complete a real payment.
