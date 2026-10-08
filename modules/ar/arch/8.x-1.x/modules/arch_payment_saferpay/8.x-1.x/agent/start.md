<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Saferpay Payment Gateway (arch_payment_saferpay) — agent index

Saferpay (Worldline/SIX) hosted-Payment-Page card gateway for the Arch suite. Depends on `arch`,
`arch_payment`. Package `Arch Payment`. Project `arch` (`8.x-1.0-alpha26`).

- **Config (credentials, test/live, SCA) & the API flow** → [config/settings.md](config/settings.md)

## Provides

- `PaymentMethod` plugin **`saferpay`** (`Plugin\PaymentMethod\Saferpay` extends
  `ConfigurablePaymentMethodBase`, implements `ConfigurableArchPluginInterface`,
  `PluginFormInterface`), label "Credit card", `callback_route = arch_payment_saferpay.redirect`.
- Service **`arch_payment_saferpay_handler`** (`Saferpay\SaferpayHandler`) — Guzzle `http_client`,
  config, state, entity_type.manager, current_user, request_stack, language_manager.
- Controller `Controller\SaferpayPaymentController` + routes (`arch_payment_saferpay.routing.yml`,
  all `_permission: access content`, `no_cache: TRUE`):
  - `.redirect` `/payment/saferpay/redirect` — `redirectPage()` (Initialize → `TrustedRedirectResponse`
    to Saferpay).
  - `.success` `/payment/saferpay/success` — `paymentSuccess()` (Assert + Capture → redirect
    `arch_checkout.complete`).
  - `.error` `/payment/saferpay/error`, `.cancel` `/payment/saferpay/cancel` — message + back to
    `arch_checkout.checkout`.
- Config **`arch_payment_saferpay.settings`** (`customer_id`, `terminal_id`, `username`, `password`,
  `spec_version`, `force_sca`); schema `arch_payment_saferpay.config`. **Test mode** is a separate
  state flag `arch_payment_saferpay_test` (default TRUE).
- No permissions, no plugin types of its own.

## API flow (`SaferpayHandler`)

- `setOrder($id)` loads the `order` (rejects if missing, already `completed`, or lacking
  currency/subtotal).
- `callInitialize()` → `/Payment/v1/PaymentPage/Initialize`, stores `saferpay_token` on the order.
- `callAssert()` → `/Payment/v1/PaymentPage/Assert` (by token), stores `saferpay_transaction`.
- `callCapture($txnId)` → `/Payment/v1/Transaction/Capture`, stores `saferpay_capture`.
- HTTPS + HTTP basic auth (`username`/`password`), Guzzle default TLS verification (not disabled),
  `timeout` 100. Amount = `grandtotal_gross` rounded to the currency rounding step ×100.
