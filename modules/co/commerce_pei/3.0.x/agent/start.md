<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Pei Payment Gateway (commerce_pei) — agent index

On-site Drupal Commerce payment gateway for **Pei** (https://pei.is), an Icelandic
buy-now-pay-later / installment payment provider. The buyer authorizes a purchase during
checkout using their **SSN (kennitala) + a one-time SMS PIN**; the order is then charged
**server-side** against Pei's OAuth2-authenticated REST API. Version **3.0.0-alpha3**.
Core `^10 || ^11`. License GPL-2.0-or-later.

Dependencies: `commerce:commerce_payment`, `drupal:telephone` (info.yml); Composer requires
`drupal/commerce ^2.25 || ^3.0`. No routes, no controllers, no permissions, no config schema,
no `.module`/`.install`, no Drush.

- **The gateway plugin, its config keys, the checkout PIN flow, and operating it** →
  [gateway.md](gateway.md)
- **The Pei REST client: OAuth2 auth, Orders + PurchaseAccess resources, error handling** →
  [api/client.md](api/client.md)

## What it actually provides (from source)

- **Payment gateway plugin** `pei` — `OnsitePeiPaymentGateway`
  (`src/Plugin/Commerce/PaymentGateway/OnsitePeiPaymentGateway.php`), extends
  `OnsitePaymentGatewayBase`, implements `OnsitePaymentGatewayInterface` +
  `SupportsUpdatingStoredPaymentMethodsInterface`. `payment_method_types = {"pei"}`.
- **Payment method type** `pei` — `PeiPaymentMethodType`
  (`src/Plugin/Commerce/PaymentMethodType/PeiPaymentMethodType.php`), adds three string fields
  to the payment method entity: `telephone`, `issn` (the buyer's SSN), `pincode`.
- **Plugin forms**: `PeiPaymentMethodAddForm` (the AJAX SSN → request PIN → confirm PIN flow)
  and `PaymentMethodEditForm` (`src/PluginForm/`).
- **API client service** `pei` = `Drupal\commerce_pei\Api\PeiApi` (`commerce_pei.services.yml`),
  plus logger channel `logger.channel.commerce_pei`.
- Injectable API surface (`src/Api/`): `PeiApi` (request dispatcher), `PeiApiAuthorization`
  (OAuth2 client-credentials token), resources `Orders` and `PurchaseAccess`, `PeiApiException`
  (maps ~55 Pei error codes to messages), `ResponseTrait`, `ResourceBase`.

## Key facts

- **On-site, buyer-present, synchronous.** No routing.yml, no return/notify controller, no
  inbound async callback — nothing accepts a request from Pei. `createPayment()` calls
  `orders->submit()` synchronously and marks the payment `completed`.
- **Gateway config keys** (`OnsitePeiPaymentGateway::defaultConfiguration()`): `merchant_id`,
  `user_id` (OAuth client id), `password` (OAuth secret), `copy_profile_fields`, `mapping_issn`,
  `mapping_telephone`, plus the base `mode` (`test`|`live`) and `display_label`. Stored on the
  `commerce_payment.commerce_payment_gateway.*` config entity.
- **The gateway entity must have machine id `pei`.** `PeiApi::__construct()` hard-reads
  `commerce_payment.commerce_payment_gateway.pei` config; a differently-named gateway leaves the
  service unconfigured and its `mode` match throws `InvalidRequestException`. See
  [gateway.md](gateway.md).
- **Endpoints (hardcoded constants):** API `https://api.pei.is` (live) /
  `https://externalapistaging.pei.is` (test); OAuth token `https://auth.pei.is/core/connect/token`
  (live) / `https://authstaging.pei.is/core/connect/token` (test). TLS verification left at Guzzle
  defaults (enabled); redirects disabled (`ALLOW_REDIRECTS => FALSE`).
- **Test credentials** (public, from README): client id `democlient`, secret `demosecret`,
  merchant id `4`.
- Test coverage: `tests/src/Unit/PeiApiUnitTest.php` (mocked Guzzle handler for auth + purchase
  access).
