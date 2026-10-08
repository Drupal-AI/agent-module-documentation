<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transaction response page, event, and payment buttons

## Response page (`src/Controller/TransactionResponse.php`)

Route `epayco.transaction.default_response` → `/epayco/transaction/response`, controller
`TransactionResponse::responsePage`, custom access `TransactionResponse::checkAccess`.

- `checkAccess(AccountInterface $account)` — allowed only when the `ref_payco` query param is non-empty **and** the
  account has permission `access epayco transaction response`.
- `responsePage()` — reads `ref_payco` from the query, calls `epayco.handler`
  `getReferenceRemoteData($remote_ref)` to look the payment up on ePayco, and if the result has a truthy `success`
  key dispatches `GatewayTransactionEvent` on `GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` with context
  `{method:'GET', module:'epayco', request}`. Renders theme `epayco__transaction_response` with `#data`/`#context`.

This is the default landing page for standalone (non-Commerce) payments; the returned data is displayed via
`templates/epayco--transaction-response.html.twig`.

## Event (`src/Event/`)

- `GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` = `'epayco.transaction.response'`.
- `GatewayTransactionEvent` — carries `getTransactionData()` (the remote payment data) and `getContext()`.
  Both the base response page and the Commerce gateway dispatch it; `epayco_business_rules` subscribes to it.

## Payment buttons (`src/PaymentOptionsHandler.php`, service `epayco.payment_options.handler`)

`buildRenderablePaymentOption(array $checkout_values, array $context = [])` builds a render array (theme
`epayco__payment_option`, library `epayco/payment.option.behavior`) that becomes a clickable ePayco checkout
element. Required keys: `key`, `test`, `name`, `description`, `currency`, `amount`; missing keys flag the element
with `js--epayco--payment-option--error`. If no `response` is supplied it defaults to the
`epayco.transaction.default_response` route (absolute). `convertPaymentValuesToAttributes()` maps each value to a
`data-epayco-*` attribute (e.g. `amount` → `data-epayco-amount`, plus optional `tax_base`, `tax`, `invoice`,
`confirmation`, billing fields, `methodsDisable`). The JS behavior (`js/epayco--payment-option.js`) reads those
attributes and launches ePayco's `checkout.js`.

Use this for donation / quick-pay pages without Drupal Commerce; Commerce's one-page gateway reuses it.
