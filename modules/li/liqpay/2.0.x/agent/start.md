<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LiqPay API 3.0 (v2) — agent index

LiqPay payment gateway: builds a LiqPay checkout form, records payments in `payments_liqpay`,
and processes LiqPay's signed server callback. Integrates with the `basket` module (optional) via
a Basket payment plugin. Config at `/admin/config/development/liqpay` (`liqpay.settings`).

- **Settings form keys, sandbox vs live keys, routes, permission** → [configure/settings.md](configure/settings.md)
- **The `LiqPay` service, `payments_liqpay` table, checkout form, and the signed callback flow** →
  [api/payments.md](api/payments.md)
- **The four alter/invoke hooks** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Routes: `liqpay.settings` + `liqpay.payments` (`_permission: access liqpay settings`, restricted);
  `liqpay.pages` `/liqpay/{page_type}` (`_permission: access content`) with page types
  `api` (callback), `pay` (checkout form), `payment_result` (outcome).
- Callback signature check: `base64_encode(sha1($private_key . $data . $private_key, 1)) == $signature`
  before any status update (`LiqpayPages::pages`, case `api`).
- Success statuses: `success|sandbox|subscribed|unsubscribed|hold_wait` (`LiqPay::LIQPAY_SUCCESS_STATUS`).
- Config `liqpay.settings` `config.*`: `sandbox`, `public_key`(_sandbox), `private_key`(_sandbox),
  `currency`, `description.{en,uk,ru}`, `success.{lang}`. Sandbox keys override live when `sandbox` on.
