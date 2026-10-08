<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Ifthenpay (commerce_ifthenpay) — agent index

**Drupal Commerce payment gateways for [ifthenpay](https://ifthenpay.com/)**, the Portuguese payment
provider. Three payment methods, each a gateway plugin; the base module ships **Multibanco**, two
submodules add **MB WAY** and **credit card**. Package `Commerce (contrib)`. Core `^10 || ^11`.
License GPL-2.0-or-later. Installed version **3.0.2** (version dir `3.0.x`). Depends only on
`commerce:commerce_payment` (the MB WAY submodule also needs `commerce_cart`, from its route/service).

## Dependencies

- Base `.info.yml`: **`commerce:commerce_payment`**. `composer.json`: `drupal/commerce ^2.0 || ^3.0`.
- **No external PHP library.** HTTP is core Guzzle (`@http_client`).
- MB WAY submodule uses `commerce_cart` (`CartSessionInterface`) and core `flood` + `csrf_token`.
- Optional runtime integration: **`commerce_log`** — when enabled, reference/collision/mismatch
  events are written to the order activity log (all guarded; absence never breaks payment).

## What it provides (from source)

Three `@CommercePaymentGateway` plugins:

- **`ifthenpay`** — "Ifthenpay - Multibanco" (base). `src/Plugin/Commerce/PaymentGateway/Ifthenpay.php`.
  Extends `PaymentGatewayBase`, implements `ManualPaymentGatewayInterface` +
  `SupportsNotificationsInterface`, `payment_type = payment_manual`. Customer gets an
  entity/reference to pay at a Multibanco ATM or home-banking. Two reference-generation modes (see
  below).
- **`ifthenpay_mbway`** — "Ifthenpay - MB WAY" (`commerce_ifthenpay_mbway`).
  On-site gateway (`OnsitePaymentGatewayInterface` + `SupportsVoidsInterface` +
  `SupportsNotificationsInterface`). Custom payment method type `commerce_ifthenpay_mbway` (field
  `mbway_number`). At checkout it POSTs to ifthenpay's `SetPedidoJSON` to push a payment prompt to the
  customer's phone.
- **`ifthenpay_cc`** — "Ifthenpay - Credit Card" (`commerce_ifthenpay_cc`).
  Off-site redirect gateway (`OffsitePaymentGatewayBase`), `payment_method_types = {credit_card}`.
  Creates a remote charge via the ifthenpay CC API and redirects to its hosted page.

Also: two theme hooks (`multibanco_instructions`, `mbway_instructions`) + Twig templates; a value
object `ReferenceResult`; `MultibancoApiClient` service (`commerce_ifthenpay.multibanco_api`);
`SettlesOrderBalanceTrait` (recalculates order balance immediately after a notification completes a
payment, retrying on `OrderVersionMismatchException`); config schema for each gateway; commerce_log
categories/templates YAML. **No `.install`, no `.permissions.yml`, no JS/libraries, no cron.**

## Reference generation modes (Multibanco)

- **API (MB Key) — recommended, default for new gateways.** `createApiPayment()` calls
  `MultibancoApiClient::requestReference()` → `POST https://api.ifthenpay.com/multibanco/reference/
  init` (or `/sandbox`), storing the returned reference/entity/requestId/expiry in order data. No
  order-id limit, no collisions, optional expiry. Requires the MB Key.
- **Offline (entity/sub-entity) — default for pre-existing gateways.** `generateMbRef()` computes the
  9-digit reference locally from entity+sub-entity+order-id+amount with the ifthenpay check-digit
  algorithm. Order ids > 9999 are CRC32 hash-mapped into 4 digits (collision risk; mitigated by
  collision-aware notification matching). Kept for backwards compatibility / no-MB-Key accounts.

## Confirmation / verification posture (positive)

Server-authoritative on the money paths. **Multibanco** confirms via an **authenticated ifthenpay
callback** (`onNotify`): the anti-phishing shared secret is validated with a strict compare, the
entity is bound per payment, the optional requestId is validated, and the callback amount is matched
to the local pending payment before completion. **Credit card** `onReturn()` recomputes
`SK = SHA-256(orderId + amount + requestId + cccard_key)`, rejects on strict mismatch, and re-checks
the charged amount against the server-side order total. **MB WAY** confirms via its own
anti-phishing-keyed callback. All remote calls go to hardcoded HTTPS ifthenpay hosts with TLS
verification on. Handle every key (`mb_key`, `multibanco_chaveAntiPhishing`, `mbway_key`,
`callback_antiphishing`, `cccard_key`) as a secret; they live in gateway config. Details:
[callbacks.md](callbacks.md).

## Solution docs

- **Gateway plugins, config fields, reference modes, MB WAY method type & checkout, CC redirect** →
  [payment-gateways.md](payment-gateways.md)
- **Notify/return confirmation flows, callback URLs, MB WAY storefront repayment endpoint, balance
  settling** → [callbacks.md](callbacks.md)
