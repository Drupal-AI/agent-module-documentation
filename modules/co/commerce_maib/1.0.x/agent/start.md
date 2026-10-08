<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce MAIB (commerce_maib) — agent index

**Off-site *redirect* payment gateway for MAIB (Moldova Agroindbank / maib ecomm)** for Drupal
Commerce. The customer is redirected (auto-POST) to MAIB's hosted card page, pays there, and the
module confirms the outcome by **re-querying MAIB's API server-side over a mutual-TLS client
certificate** — the recorded payment reflects the bank's authoritative answer, not anything the
browser hands back. Built on the `maib/maibapi` PHP library.

Package `Commerce (contrib)`. `type: module`. Core `^8.8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version **1.0.8** (version dir `1.0.x`). Composer
`drupal/commerce_maib`.

## Dependencies

- Drupal module (`.info.yml`): **`commerce:commerce_payment`**.
- Composer (`composer.json`): **`drupal/commerce` `^2.0 || ^3.0`**,
  **`maib/maibapi` `^2.0 || ^3.0`** (the API client + bundled test cert/constants),
  **`monolog/monolog` `^2.0 || ^3.0`** (used only for the optional Guzzle debug log).
- No submodules, no provided permissions, no Drush commands.

## What it provides (from source)

- **Payment gateway plugin** `maib_redirect` — `label` "MAIB (Off-site redirect)",
  `src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`, extends `OffsitePaymentGatewayBase`
  and implements `SupportsAuthorizationsInterface` + `SupportsRefundsInterface`.
  `payment_method_types = {credit_card}`; `credit_card_types = {mastercard, visa}`;
  `requires_billing_information = FALSE`. Declares one form:
  `offsite-payment` → `PaymentOffsiteForm`.
  - **Config fields** (schema in `config/schema/commerce_maib.schema.yml`): `private_key_path`
    (path to the private-key PEM), `private_key_password` (PFX passphrase), `public_key_path`
    (path to the certificate PEM), `intent` (`capture` | `authorize`). Plus the non-schema UI
    toggles `debug` / `debug_file` and the base `mode` (test/live). The config form also prints
    the **Return and Cancel URLs to give the bank** and openssl instructions for extracting the
    PEM files from the bank's `.pfx`.
  - **Transaction ops**: `capturePayment()` (`makeDMSTrans`, authorize→complete),
    `voidPayment()` (`revertTransaction`, deletes the payment), `refundPayment()`
    (`revertTransaction`; MAIB supports full refund of the authorised amount). All check
    `RESULT == OK` and throw `MAIBException` otherwise.
  - `getClient()` builds a `Maib\MaibApi\MaibClient` on a Guzzle client with the merchant
    client cert (`cert` + `ssl_key` + passphrase) and **full TLS verification**
    (`verify => TRUE`, `CURLOPT_SSL_VERIFYPEER => TRUE`, `CURLOPT_SSL_VERIFYHOST => 2`).
    Endpoint/redirect URLs come from `MaibClient` constants and switch on test/live `mode`.
- **Offsite redirect form** `PluginForm/OffsiteRedirect/PaymentOffsiteForm` — at the checkout
  "payment" step it registers the transaction with the bank (`registerSmsTransaction` for
  capture, `registerDmsAuthorization` for authorize) using the **server-side amount**, stores a
  pending `commerce_payment` (`remote_id = TRANSACTION_ID`), then auto-POSTs the browser to the
  bank redirect URL with `trans_id` + `language`.
- **Return/cancel controller** `Controller/PaymentCheckoutController`
  (`commerce_maib.routing.yml`): `checkout_return` (`/commerce-maib/return`) and
  `checkout_cancel` (`/commerce-maib/cancel`), both gated by
  `_custom_access: PaymentCheckoutController::checkAccess`. The bank posts `trans_id` here; the
  controller resolves the order from the payment and **redirects (302) into Commerce's own
  return/cancel route** (the module never confirms payment in the controller — Commerce then
  calls the plugin's `onReturn`). See [payment-flow.md](payment-flow.md).
- **`onReturn()`** (in the plugin) — the server-authoritative confirmation: re-queries
  `getTransactionResult($transId, $orderIp)` and sets `completed` / `authorization` / `pending`
  by the bank's `RESULT`, deleting the payment on a hard failure.
- **Cron maintenance** (`commerce_maib.module` `hook_cron` + `PaymentWorker` queue worker,
  `commerce_maib_queue`): once per day calls `closeDay()` per gateway ("close business day"),
  and queues any `new`/`authorization` payments past their `expires` time to reconcile their
  status against the bank (`getTransactionResult`), completing or deleting them.
- **`payment_info` base field** on `commerce_payment` (`hook_entity_base_field_info`, map type;
  installed by `commerce_maib_update_8101`) storing the bank response, rendered read-only in the
  `commerce_order_payments` admin view via `hook_preprocess_views_view_field`.
- **Checkout form alter** `hook_form_commerce_checkout_flow_alter` — hides the core form
  id/token/build-id elements on the MAIB offsite payment step (the step auto-POSTs to the bank).
- **`MAIBGateway`** (`src/MAIBGateway.php`) — constants for request keys (`trans_id`,
  `TRANSACTION_ID`, `RESULT`) and result states (`OK`, `FAILED`, `CREATED`, `PENDING`,
  `DECLINED`, `REVERSED`, `AUTOREVERSED`, `TIMEOUT`). **`MAIBException`** extends
  `PaymentGatewayException`.

## Security posture (payment gateway)

Sound / server-authoritative. Confirmation of a payment happens in `onReturn()` (and the cron
worker) by **re-querying MAIB's API over the merchant mutual-TLS client certificate** and reading
the bank's `RESULT`; the browser return only carries an opaque `trans_id` used to look up the
pre-registered payment. The credited **amount is the server-side order balance** fixed at
registration — never a request-supplied value — so a tampered return can change neither the amount
nor the result. TLS is fully verified (`verify => TRUE`, peer + host checks on). No
request-supplied URL is fetched (no SSRF). The `access checkout`-gated return endpoint is anon-
reachable by design (offsite customer return), but the privileged act is gated by the authenticated
bank re-query. Operational rules: keep the **certificate/private key outside the web root**, never
commit the key or the PFX passphrase, keep the debug log out of the docroot, and serve over HTTPS.
See [payment-flow.md](payment-flow.md).

## Solution docs

- **Registration → redirect → return → confirmation lifecycle, cron reconciliation, capture/
  void/refund, config fields** → [payment-flow.md](payment-flow.md)
