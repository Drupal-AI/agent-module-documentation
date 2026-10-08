<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ViaBill Payments (viabill_payments) — agent index

Off-site (redirect) **Drupal Commerce payment gateway** for **ViaBill** "Buy Now, Pay Later"
(BNPL), plus optional ViaBill installment **PriceTags** on product/cart/checkout pages. Package
`Commerce (Payment)`. Version 2.1.0 (dir `2.1.x`). Core `^10 || ^11`. License GPL-2.0-or-later.
Depends on `commerce`, `commerce_payment`, `commerce_log`; composer requires `drupal/commerce:^3.0`.

2.1.x is a compatibility release over 2.0.x: Drupal 11 support, `composer.json` bumped to Commerce
3.x, and `REQUEST_TIME` replaced with `$this->time->getRequestTime()` in `capturePayment()`
(see `CHANGELOG.md`). No new features or routes.

- **The payment gateway plugin — checkout redirect, capture/void/refund, config form** →
  [plugins/payment-gateway.md](plugins/payment-gateway.md)
- **Credentials, PriceTag settings, config objects and keys** →
  [configure/settings.md](configure/settings.md)
- **Off-site checkout request, the `/payment/viabill/callback` notify flow, and the ViaBill API
  client** → [api/callback-flow.md](api/callback-flow.md)

## What it actually is (from source)

- One Commerce payment gateway plugin: `ViaBillPayments` (id **`viabill_payments`**,
  `src/Plugin/Commerce/PaymentGateway/ViaBillPayments.php`), extending
  `OffsitePaymentGatewayBase` and implementing `SupportsRefundsInterface`, `SupportsVoidsInterface`.
  Plugin forms: `offsite-payment` → `ViaBillPaymentsForm`, `capture-payment` → `CapturePaymentForm`.
  `payment_type = payment_default`.
- Two routes (`viabill_payments.routing.yml`):
  - `viabill_payments.callback` — `POST /payment/viabill/callback`, `_access: 'TRUE'` →
    `ViaBillController::callback` (the ViaBill server-to-server notification handler).
  - `viabill_payments.account_form` — `/admin/config/viabill/account`,
    `_permission: 'administer commerce_payment_gateway'` → `ViaBillAccountForm` (standalone
    credentials form).
- Helper/API classes in `src/Helper/`: `ViaBillGateway` (API client + signature logic),
  `ViaBillOutgoingRequests` (Guzzle wrapper), `ViaBillServices` (API endpoint catalog),
  `ViaBillHelper` (config/mode accessors, formatting, logging), `ViaBillConstants` (enums,
  ISO codes).
- Presentation hooks in `viabill_payments.module` inject the PriceTag `<div>`/script on
  `commerce_product_variation` view, `commerce_product` preprocess, the cart Views form, the
  order total summary and the checkout order summary. Library `viabill_payments/styles`
  (`css/viabill-payments.css`).
- Config object **`viabill_payments.settings`** stores the credentials + PriceTag options for the
  hooks; the gateway plugin configuration is the primary store. **No `config/` schema ships and
  there is no `.permissions.yml`, `.install`, or Drush command** in this project.
- `commerce_log` template `viabill_partial_capture` (`viabill_payments.commerce_log_templates.yml`).
- Dead/unrouted code: `ViaBillLoginForm` / `ViaBillRegisterForm` classes exist but no route wires
  them; `ViaBillAccountForm` states no remote register/login call is made — credentials are entered
  manually.

## Operations at a glance

- Authorize-only vs. authorize-and-capture chosen by the `transaction_type` setting; capture, void
  and refund call the ViaBill transaction API (`/api/transaction/{capture,cancel,refund}`).
- Test vs. live mode comes from the Commerce gateway `mode`; **both map to the same base URL**
  `https://secure.viabill.com` (`ViaBillOutgoingRequests::TEST_BASE_URL`/`PROD_BASE_URL`).
- Callback JSON is signature-checked (`ViaBillGateway::verifyCallbackSignature`) before a
  `commerce_payment` is created and the order advances.
