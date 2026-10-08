<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Trinion Cart Tinkoff Payment

Settings form `trinion_cart_tinkoff_payment.settings_form` → `/admin/config/system/trinion-tinkoff`, permission `administer trinion_cart_tinkoff_payment configuration`. Config object `trinion_cart_tinkoff_payment.settings` (terminal key, `secret_key`, etc.). Menu link parents under `trinion_base.config`.

## Callback verification (TinkoffController::complete)
- Reads raw `php://input` JSON; loads order `Node::load($OrderId)`.
- Recomputes token: `get_tinkoff_token()` sets `Password = secret_key`, `ksort`s the params, drops `Token`, concatenates values, `hash('sha256', …)`.
- Rejects (`exit('NOTOK')`) unless the recomputed token equals the posted `Token`.
- On `Status == CONFIRMED`: `trinion_cart.payment::processPayment(order, Amount/100, 'TinkoffPayment')` then dispatches `PaymentEvent::PAYMENT_SUCCESS`. Returns early with `OK` if already `payment_received`.
