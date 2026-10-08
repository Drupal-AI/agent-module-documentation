<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Banca Intesa — agent index

A Drupal Commerce **offsite-redirect payment gateway for Banca Intesa Serbia** (NestPay/Payten `eway2pay`
platform). Version **3.0.0-alpha10**. Core `^10 || ^11`.

## Dependencies

- `commerce`, `commerce_order`, `commerce_payment`.
- `gnikolovski/gnikolovski_payment_log` (^1.0) — pulled in by Composer; provides `gnikolovski_payment_log.service`
  used to log requests/responses and to drive the cron reconciliation.

## Surface

- **Gateway plugin** `banca_intesa_offsite_redirect` —
  `src/Plugin/Commerce/PaymentGateway/BancaIntesaOffsiteRedirect.php`
  (`OffsitePaymentGatewayBase`). Config form fields: test/live redirect URL, test/live API URL, merchant_id,
  username, password, store_key, use_display_name, send_mail, show_payment_report_table, auth_option
  (`Auth`/`PreAuth`), api_logging. `onReturn()` / `onCancel()` handle the return leg.
- **Offsite form** `src/PluginForm/OffsiteRedirect/BancaIntesaForm.php` — builds an auto-POST redirect form
  (`REDIRECT_POST`) to the bank with the signed `buildPostData()` payload.
- **Service** `src/BancaIntesaService.php` (`commerce_banca_intesa.banca_intesa_service`, autowired) —
  `getRedirectUrl()`, `buildPostData()` (computes the outbound `hash`), `isHashValid()` (verifies the return
  signature), payment-report table builders, `sendMail()`, and `isRemoteOrderPaid()` (server-to-server
  CC5Request `ORDERSTATUS QUERY` reconciliation).
- **Hooks** `.module` — `hook_mail` (payment report email), `hook_theme`
  (`commerce_banca_intesa_payment_report` + Twig template), `hook_cron` (reconciles pending orders via
  `isRemoteOrderPaid()`). Alter hook `commerce_banca_intesa_order_transition` lets other modules change the
  applied order transition (default `place`).
- **Install** `hook_requirements` warns/errors unless `session.cookie_samesite` is `None` (needed for the POST
  return to carry the session cookie).
- No custom routes/controllers; return/cancel use the standard `commerce_payment.checkout.return|cancel` routes.

## Trust boundary (return leg)

`onReturn()` (POST from the bank) rejects unless **all** hold: `ReturnOid == $order->id()`,
`clientid == merchant_id`, `isHashValid()` is TRUE, and `ProcReturnCode == '00'`; otherwise it throws
`PaymentGatewayException` and creates no payment. `isHashValid()` recomputes
`base64(sha512(fields . store_key))` and rejects on mismatch — forging a valid `HASH` requires the shared
**store_key** secret. On success the payment is recorded for **`$order->getBalance()`** (the site's own total,
never a request value). Store `store_key`/`password` as secrets; require HTTPS.

## Config / usage

See [`../usage.md`](../usage.md) and [`../human-docs/`](../human-docs/index.md). Add the gateway at
`/admin/commerce/config/payment-gateways`, choose **Banca Intesa**, enter the bank-issued merchant_id,
username, password and store_key, pick Test/Live mode, and save.
