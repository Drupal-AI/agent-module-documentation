<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway configuration form & settings

All references: `src/Plugin/Commerce/PaymentGateway/QliroCheckout.php`
(`defaultConfiguration()`, `buildConfigurationForm()`, `submitConfigurationForm()`) and
`config/schema/commerce_qliro_checkout.schema.yml`.

There is **no standalone settings page**. Configure it like any Commerce payment method at
`/admin/commerce/config/payment-gateways` → *Add payment gateway* → *Qliro Checkout*.

## Config keys (gateway plugin `qliro_checkout`)

| Key | Form element | Default | Notes |
| --- | --- | --- | --- |
| `mode` | (from base) test / live | — | Selects the Qliro API host in the SDK connector (`mode === 'test'`). |
| `api_key` | textfield, required | `''` | Qliro merchant API key. Sent as `MerchantApiKey` in every request body. |
| `api_secret` | textfield, required | `''` | Qliro API secret; used to compute the SHA-256 request MAC. Stored in gateway config — restrict who can access the gateway form and exclude the gateway config from public exports. |
| `capture` | radios | `FALSE` | `TRUE` = authorize **and** capture immediately after acknowledge; `FALSE` = authorize only (manual capture later). |
| `purchase_country` | select, required | `''` | ISO country: AT, AU, DK, FI, DE, NL, NO, SE, CH, GB, US. |
| `locale` | select, required | `sv-se` | UI locale: en-us, da-dk, nl-nl, fi-fi, fr-fr, de-de, nb-no, sv-se. |
| `terms_path` | textfield, required | `''` | Path or external URL to terms; sent as `MerchantTermsUrl`. |
| `policy_path` | textfield, optional | `''` | Integrity policy; sent as `MerchantIntegrityPolicyUrl` when set. |
| `enable_order_validation` | checkbox | `FALSE` | Reserved — the validation callback is a no-op stub in this release. |
| `update_billing_profile` | checkbox | `TRUE` | Copy Qliro `BillingAddress` onto the order's billing profile on acknowledge. |
| `update_shipping_profile` | checkbox | `FALSE` | Copy Qliro `ShippingAddress` onto the shipping profile; only shown when `commerce_shipping` is installed. |
| `allow_separate_shipping_address` | checkbox | `FALSE` | Lets the shopper enter different billing/shipping addresses at Qliro. |
| `log_requests` | checkbox | `FALSE` | When on, logs the outbound create/update/capture/refund payloads (via `print_r`) to the `commerce_qliro_checkout` logger channel (dblog). The MAC/secret is added later in the SDK connector and is not part of the logged payload. |

`allowed_customer_types` exists in `defaultConfiguration()` but has no form element and is not
persisted by `submitConfigurationForm()`.

## Credentials

The form accepts `api_key` / `api_secret` as text fields; this release does not expose a Key
entity selector, so the values are entered directly and saved into the payment-gateway config
entity. Treat the gateway configuration as sensitive: limit the *administer payment gateways*
capability and keep the gateway config out of any publicly shared configuration export.

## Merchant URLs sent to Qliro

Built in `QliroManager::buildOrderRequest()` from the offsite form's URLs
(`src/PluginForm/OffsiteRedirect/QliroCheckoutForm.php`): `MerchantConfirmationUrl` = return URL,
`MerchantCheckoutStatusPushUrl` = notify URL (`getNotifyUrl()`), `MerchantCancelUrl` = cancel
URL, `MerchantTermsUrl` / `MerchantIntegrityPolicyUrl` from `terms_path` / `policy_path`.
`MerchantOrderValidationUrl`, `MerchantOrderAvailableShippingMethodsUrl` and
`MerchantOrderManagementStatusPushUrl` are not usefully wired in this release.
