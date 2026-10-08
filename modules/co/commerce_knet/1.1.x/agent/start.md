<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce KNET (commerce_knet) — agent index

**Off-site *redirect* payment gateway for KNET**, Kuwait's national debit-card
network, for Drupal Commerce. At checkout the shopper is redirected (browser GET)
to the KNET hosted payment page; KNET then POSTs an **AES-encrypted `trandata`
response** back to a module callback that records a Commerce payment. No card data
is stored on the Drupal side.

Package `Commerce (contrib)`. `type: module`. Installed version **1.1.0**
(version dir `1.1.x`). Core `^8 || ^9 || ^10 || ^11` per `.info.yml`
(`composer.json` says `^8.7 || ^9 || ^10 || ^11`). License GPL-2.0-or-later.
Composer `drupal/commerce_knet`. Maintainer: Nikunj Kotecha.

> Compatibility caveat (from source): `src/Helper/SecureText.php` (line 120) uses
> PHP-7-only curly-brace string-offset syntax `$text{…}`, which is a **parse
> error on PHP 8.0+**. `php -l` fails on PHP 8.4. Because Drupal 10/11 require
> PHP 8, the encrypt (checkout redirect) and decrypt (return) paths that call
> this helper will fatal on those cores until the line is patched to `$text[…]`.
> Enabling the module does not break the site globally — the class only loads when
> its methods are invoked (i.e. at checkout / return time).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`** (brings in
  Commerce core + the payment framework). Routes also declare
  `_module_dependencies: commerce_checkout`.
- Composer: `php >=7.4.0`, `drupal/core`. No third-party PHP libraries.

## What it provides (from source)

- **Payment gateway plugin** `knet`
  (`src/Plugin/Commerce/PaymentGateway/Knet.php`), extends
  `OffsitePaymentGatewayBase` implements `KnetInterface`.
  `payment_method_types = {credit_card}`; `credit_card_types = {knet}`;
  `requires_billing_information = FALSE`. Declares one form:
  `offsite-payment` → `KnetPaymentOffsiteForm`. Also implements
  `buildPaymentInstructions()` (shows tranid / paymentid / status on the receipt).
  - **Config fields** (`defaultConfiguration` / `buildConfigurationForm`):
    `endpoint_live` (default `https://kpay.com.kw/kpg/PaymentHTTP.htm`),
    `endpoint_test` (default `https://kpaytest.com.kw/kpg/PaymentHTTP.htm`),
    `tranportal_id`, `tranportal_password`, `terminal_resource_key`, and `udf5`
    (a tokenized string, default `[order_number]`). Plus the base `mode`
    (test/live) and display fields. The active endpoint is chosen as
    `endpoint_<mode>`.
- **Off-site redirect form** `PluginForm/KnetPaymentOffsiteForm` — builds the
  redirect to KNET via `KnetToolKit` and `buildRedirectForm(... 'GET')`. Sets
  return URL `commerce_knet.checkout.return` and error URL
  `commerce_knet.checkout.cancel`, the amount, `trackid` = order number,
  language, and UDF fields (see [payment-flow.md](payment-flow.md)).
- **Toolkit** `Toolkit/KnetToolKit` — assembles the KNET request string
  (`id`, `password`, `amt`, `trackid`, `currencycode=414` (KWD), `langid`,
  `action=1` purchase, `responseURL`, `errorURL`, `udf1..udf5`), **encrypts** it
  with the terminal resource key, and returns the redirect URL
  `…/PaymentHTTP.htm?param=paymentInit&trandata=<enc>&tranportalId=…`.
- **Crypto helper** `Helper/SecureText` — static `encrypt()` / `decrypt()` using
  `AES-128-CBC`, `OPENSSL_ZERO_PADDING`, manual PKCS5 padding, IV = first 16
  bytes of the key (the KNET-mandated scheme). See the compatibility caveat above.
- **Return/cancel controller** `Controller/KnetController` (extends
  `PaymentCheckoutController`) — `returnPage()` decrypts and parses the KNET
  `trandata`, validates the outcome server-side, and records the payment;
  `cancelPage()` handles failures/cancellations. See
  [payment-flow.md](payment-flow.md).
- **Routes** (`commerce_knet.routing.yml`):
  - `commerce_knet.checkout.return` — `/checkout/{commerce_order}/{step}/knet-success`
  - `commerce_knet.checkout.cancel` — `/checkout/{commerce_order}/{step}/knet-failure`
  - Both `_access: 'TRUE'` (unauthenticated gateway callback, the norm),
    `_module_dependencies: commerce_checkout`, `commerce_order` bound as an entity
    parameter.
- **Config schema** `config/schema/commerce_knet.schema.yml` (keys
  `endpoint`, `tranportal_id`, `tranportal_password`, `terminal_resource_key`,
  `udf1..udf5`). Note this drifts from the plugin, which stores
  `endpoint_live`/`endpoint_test` and only `udf5`.

## Return handling (server-side)

On the KNET POST back, `returnPage()` reads the response, decrypts the `trandata`
with the merchant **terminal resource key**, and checks the outcome **server-side**
before recording a payment: the transaction result must be `CAPTURED`, the
returned order id (`udf3`) must equal the order in the URL, and the returned
amount (`amt`) must equal the order's own total (`$order->getTotalPrice()`). The
recorded `Price` uses the order's currency code. Credentials
(`tranportal_password`, `terminal_resource_key`) are gateway config; the README
recommends overriding them in `settings.php` rather than storing live values in
the database/config export. Serve the callback over HTTPS.

## No permissions / no services / no hooks

The module defines no `*.permissions.yml`, no `*.services.yml`, no `.module` /
`.install`, no `*.api.php`, no templates, no JS/CSS. (data.json's
`provides_permissions` is a metadata artifact; there is no permissions file on
disk.) All behaviour is the gateway plugin + toolkit + controller above.

## Solution docs

- **Redirect build, UDF/token mapping, return parsing & server-side checks,
  config fields** → [payment-flow.md](payment-flow.md)
