<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BeGateway Payment (commerce_begateway) — agent index

A **Drupal Commerce off-site redirect payment gateway** for the **beGateway /
eComCharge** platform. The shopper is redirected to a beGateway-hosted checkout
page to pay; the order is completed on the return leg and/or an asynchronous
webhook (IPN) notification. Package `commerce`. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed as **8.x-1.6**
(version dir `8.x-1.x`). Configure via the Commerce payment-gateway UI
(`configure: commerce_payment.configuration`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`** and **`token`**.
- PHP library: **`begateway/begateway-api-php`** — `composer.json` requires `^5`;
  `ludwig.json` pins `4.4.1`; `commerce_begateway.libraries.yml` names `5.1.0`.
  `hook_requirements()` (`.install`) blocks install if `\BeGateway\Settings` is
  missing.

## What it provides (from source)

Only two PHP classes — no custom routing, services, or permissions files (the
notify/return routes come from Commerce's `OffsitePaymentGatewayBase`).

- **Payment gateway plugin** `begateway_offsite_gateway`
  (`src/Plugin/Commerce/PaymentGateway/BeGateway.php`, label "BeGateway Payment
  Gateway"), extends `OffsitePaymentGatewayBase` and implements
  `SupportsNotificationsInterface`. Payment method type `credit_card`; card types
  amex/dinersclub/discover/jcb/maestro/mastercard/visa; modes test/live;
  `requires_billing_information = FALSE`.
- **Off-site redirect form** `src/PluginForm/OffsiteRedirect/BeGatewayForm.php`
  (`BeGatewayForm extends PaymentOffsiteForm`) — builds the payment token and the
  auto-POST redirect to the beGateway checkout page.
- **Config**: `config/install/commerce_begateway.settings.yml` seeds defaults
  (incl. beGateway's public **test** shop id `361` / test secret /
  `checkout.begateway.com`); `config/schema/commerce_begateway.schema.yml`
  defines the gateway plugin config schema.
- **Translations**: bundled `ru` (`translations/ru.po`, `.mo`).

## Configuration fields (gateway plugin form)

Set on the Commerce payment gateway (`buildConfigurationForm`), stored in the
`commerce_payment_gateway` config entity:

- **`shop_id`** — beGateway shop id (required).
- **`shop_key`** — shop secret key (required); labeled "Shop secrey key" [sic].
  Used both to build the payment request and to authorize the incoming webhook.
- **`action`** — `payment` or `authorization` (select, required).
- **`checkout_domain`** — payment-page domain, e.g. `checkout.begateway.com`
  (required); the module prefixes `https://`.
- **`description`** — payment description, token-enabled with `commerce_order`
  tokens (required).
- **`timeout`** — minutes the shopper has to pay (sets the token expiry).
- **`enable_bankcard`** / **`enable_erip`** / **`enable_halva`** — yes/no toggles
  selecting which beGateway payment methods are offered.
- Plus the standard Commerce **mode** (Test/Live).

## Payment flow (from source)

1. **Redirect out** — `BeGatewayForm::buildConfigurationForm` sets
   `\BeGateway\Settings::$shopId/$shopKey/$checkoutBase`, builds a
   `\BeGateway\GetPaymentToken` (amount, currency, tracking_id = order id,
   customer/billing, notify URL = `getNotifyUrl()`, success/decline/fail =
   `#return_url`, selected payment methods, expiry), `submit()`s it, and
   auto-POSTs the shopper to the returned redirect URL.
2. **Return** — `BeGateway::onReturn()` reads only `uid` from the query, then
   makes a **server-side** `\BeGateway\QueryByUid` call to fetch the real
   transaction and validates it (`isPaymentValid` + success/pending) before
   accepting; throws `PaymentGatewayException` otherwise. It does not trust posted
   return parameters.
3. **Webhook / IPN** — `BeGateway::onNotify()` builds `\BeGateway\Webhook()` and
   returns early unless **`$webhook->isAuthorized()`** (shop-id/secret credential
   check) passes, then runs `isPaymentValid()`, creates/updates the
   `commerce_payment`, and completes the order on success. Amount, currency, and
   `tracking_id` are re-validated against the loaded order.

## Security posture (positive)

- Webhook/notification is **authenticated server-side** (`isAuthorized()`, shop
  secret) before any order state changes — the posted status is not trusted blind.
- The return path **re-queries the gateway server-side** rather than trusting
  return-URL parameters.
- **Amount, currency, and order id are re-validated** against the server-side
  order total in `isPaymentValid()`.
- TLS is enforced by the SDK (`CURLOPT_SSL_VERIFYPEER = true`); the module only
  ever uses `https://` endpoints.
- Store `shop_id`/`shop_key` via environment variables rather than committing
  them to exported config.

## Related docs

- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md)
- Semantic overview: [`../usage.md`](../usage.md)
