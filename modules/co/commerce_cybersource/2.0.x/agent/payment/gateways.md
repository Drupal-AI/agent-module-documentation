<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CyberSource payment gateways — install, config, operations

Three gateway plugins live in `src/Plugin/Commerce/PaymentGateway/`. All log to the
`logger.channel.commerce_cybersource` channel. Add any of them at
`/admin/commerce/config/payment-gateways`.

## Install / enable

```
composer require drupal/commerce_cybersource
drush en commerce_cybersource
```

Pulls `cybersource/rest-client-php` (Centarro fork of the CyberSource REST SDK) and
`firebase/php-jwt`. Requires the Commerce `commerce_payment`, `commerce_order`, `commerce_log`
submodules. Each gateway has a `mode` (test/live) that selects the CyberSource host.

## 1. SAHC — `cybersource_sahc` (`CyberSourceSahc`)

Off-site redirect gateway (`OffsitePaymentGatewayBase`), `payment_method_types = {credit_card}`,
`payment_type = payment_default`. **Deprecated; discontinued Sept 2026** — a warning banner is shown
on the config form. Migrate to Unified Checkout.

Config keys (`defaultConfiguration()` / schema `plugin.cybersource_sahc`): `merchant_id`,
`profile_id`, `access_key`, `secret_key` (256-char), `transaction_type`
(`sale,create_payment_token` default, or `authorization,create_payment_token`), `locale`
(`en-US`), `log_api_calls` (0).

Redirect target (`getRedirectUrl()`): live `https://secureacceptance.cybersource.com/pay`, test
`https://testsecureacceptance.cybersource.com/pay`. The signed redirect request is built by
`src/PluginForm/CyberSourceSahcForm.php`; `signData()` produces a base64 HMAC-SHA256 of the
`key=value` field list under `secret_key`. `onReturn()`/`validateResponse()` verify the reply — see
[callbacks-and-3ds.md](callbacks-and-3ds.md). Payments settle to `pending`/`completed` and AVS codes
are recorded via `buildAvsResponseCodeLabel()`; there is no webhook, so authorized transactions are
finalized in the CyberSource dashboard.

**Note:** SAHC POSTs the customer back, so Drupal's default `SameSite=Lax` session cookie blocks the
return. README requires setting `cookie_samesite: None` in `services.yml` (needs HTTPS).

## 2. Flex Microform v2 — `cybersource_flex` (`Flex`)

On-site gateway (`OnsitePaymentGatewayBase implements FlexInterface`),
`payment_method_types = {flex_credit_card}`. Card fields are tokenized client-side by the Flex JS
(`js/flex-form.js`, library `commerce_cybersource/flex-form`); form built by `FlexForm`.

Config keys (schema `plugin.cybersource_flex`): `merchant_id`, `key_serial_number`,
`key_shared_secret`, `auth_type` (`http_signature`|`jwt_shared_secret`), `transaction_type`
(`authorization_only` default | `authorization_and_capture`), `log_api_calls`,
`enable_payer_authentication`, `skip_review_step`, `auto_submit_review_step`,
`require_3ds_challenge`.

REST host (`create()`): live `api.cybersource.com`, test `apitest.cybersource.com`. Operations use
the SDK APIs:
- `generateKey()` → `MicroformIntegrationApi::generateCaptureContext` (capture context / client
  token with `targetOrigins` = current host, allowed card networks).
- `createPaymentMethod()` → verifies the Flex transient-token JWT (see callbacks doc), stores masked
  card + `transient_token`, non-reusable, 14-min expiry.
- `createPayment()` → `PaymentsApi::createPayment`; on a transient token, requests TOKEN_CREATE for
  customer/paymentInstrument/shippingAddress, then swaps the payment method to the long-term
  paymentInstrument id and marks it reusable. Requires remote status `AUTHORIZED`, else
  `DeclineException`/`InvalidRequestException`/`PaymentGatewayException`.
- `capturePayment()` → `CaptureApi`; `refundPayment()` → `RefundApi` (tracks
  `partially_refunded`/`refunded`); `voidPayment()` → `VoidApi`.
- `onNotify()` → Payer Authentication result validation (callbacks doc).

## 3. Unified Checkout — `cybersource_unified_checkout` (`UnifiedCheckout`)

Offsite-return gateway (`OffsitePaymentGatewayBase implements UnifiedCheckoutInterface`),
`payment_method_types = {credit_card}`, `requires_billing_information = FALSE`. Renders the hosted
Unified Checkout widget inline via `getUnifiedCheckoutForm()` (attached by `hook_form_alter` on the
checkout `review` step, and by `UnifiedCheckoutForm` on the add-payment form).

Config keys (schema `plugin.cybersource_unified_checkout`): `merchant_id`, `key_serial_number`,
`key_shared_secret`, `auth_type`, `transaction_type`, `log_api_calls`,
`enable_payer_authentication`, `locale` (`en_US`), `country` (`US`), `allowed_card_networks`
(sequence; default VISA/MASTERCARD/AMEX/DISCOVER), `allowed_payment_types` (sequence; default
`PANENTRY`; also CLICKTOPAY/GOOGLEPAY/APPLEPAY), and a `capture_mandate` mapping (`billing_type`
NONE/PARTIAL/FULL, `request_email`, `request_phone`, `request_shipping`, `ship_to_countries`,
`show_accepted_network_icons`).

Operations: `generateCaptureContext()` →
`UnifiedCheckoutCaptureContextApi::generateUnifiedCheckoutCaptureContext` (builds locale/country,
allowed networks/types, completeMandate with 3DS + TMS token create, order line items via
`getOrderLineItems()`, billing/shipping addresses via `getFormattedAddress()` which ASCII-sanitizes
each line). `onReturn()` verifies the return JWT + creates payment method/payment (callbacks doc).
`createPayment()`, `capturePayment()`, `refundPayment()`, `voidPayment()` mirror the Flex REST
operations. `getCardType()` maps CyberSource numeric card codes (001→visa … 062→unionpay).

## REST API authentication (`auth_type`)

Both REST gateways choose auth in `create()`:
- `http_signature` (default) → SDK `ApiClient` with `GlobalParameter::HTTP_SIGNATURE`. CyberSource
  is deprecating HTTP Signature in Sept 2026.
- `jwt_shared_secret` → `JwtV2ApiClient` (`src/JwtV2ApiClient.php`), which overrides
  `callAuthenticationHeader()` to mint a short-lived (120 s) JWT signed HS256 with
  `base64_decode(secret_key)`, adding a payload digest for POST/PUT/PATCH. `commerce_cybersource_post_update_add_auth_type`
  backfills `auth_type = http_signature` on existing Flex/UC gateways.

The credentials (`secret_key` / `key_shared_secret`) are stored in the gateway config entity. Card
data never reaches the server in any of the three flows. `log_api_calls` is off by default; when on,
request/response bodies (PII in cleartext) are written to the log — the form description warns not to
enable it in production.
