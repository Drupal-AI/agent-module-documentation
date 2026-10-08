<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OPP payment gateway plugins & configuration

All six plugins live in `src/Plugin/Commerce/PaymentGateway/` and extend
`CopyAndPayBase` (`implements CopyAndPayInterface extends OffsitePaymentGatewayInterface,
SupportsAuthorizationsInterface, SupportsRefundsInterface, SupportsStoredPaymentMethodsInterface`).
Add one at *Commerce → Configuration → Payment gateways → Add payment gateway* and pick the plugin.

## Plugins (id → class, payment method types)

| Plugin id | Class | display_label | payment_type | payment_method_types |
|---|---|---|---|---|
| `opp_copyandpay_card` | `CopyAndPayCard` | Credit card | `opp` | `opp_card` |
| `opp_copyandpay_bank` | `CopyAndPayBank` | Bank transfer | `opp` | `opp_bank` |
| `opp_copyandpay_virtual` | `CopyAndPayVirtualAccount` | Virtual account | `opp` | `opp_virtual`, `opp_paypal` |
| `opp_copyandpay_mbway` | `CopyAndPayMbway` | MBWAY | `opp` | `opp_virtual` |
| `opp_copyandpay_sibs_multibanco` | `CopyAndPaySibsMultibanco` | SIBS MULTIBANCO | `opp_sibs_multibanco` | `opp_virtual` |
| `opp_copyandpay_sofortueberweisung` | `CopyAndPaySofortueberweisung` | SOFORT Überweisung | `opp` | `opp_bank` |

Only the **card** gateway allows multiple brands in one instance (`allowMultipleBrands()` returns FALSE in the
base, overridden for card) — because COPYandPAY renders one widget for grouped cards but a separate widget per
non-card brand. For every non-card brand, create a dedicated gateway instance.

## Per-gateway configuration (`defaultConfiguration()` + schema)

Schema type `commerce_opp_payment_gateway_configuration` (`config/schema/commerce_opp.schema.yml`):

- `entity_id` (string, **required**) — the OPP entity/channel ID sent as the `entityId` request param.
- `access_token` (string, **required**) — bearer token; sent as `Authorization: Bearer <token>` header.
- `show_amount` (bool, default TRUE) — show payable amount on the payment page.
- `merchant_invoice_id_fallback` (`id`|`uuid`, default `id`) — order property used for `merchantInvoiceId`
  when no order number exists yet.
- `merchant_transaction_id_field` (`uuid`|`id`, default `uuid`) — payment property used for `merchantTransactionId`.
- `host_live` (default `https://eu-prod.oppwa.com`), `host_test` (default `https://eu-test.oppwa.com`) — base URLs.
- `test_mode` (`INTERNAL`|`EXTERNAL`, default `INTERNAL`) — sent as `testMode` when the gateway mode is `test`.
- `brands` (sequence of brand IDs, **required**) — chosen from `getBrandOptions()` (per-plugin).
- `cron_delete_expired_payment_intents` (bool, default TRUE), `cron_process_pending_payment_intents` (bool, default TRUE)
  — see [../api/service.md](../api/service.md).

Plus base Commerce gateway config (`mode`, `payment_method_types`, `collect_billing_information`, …).

### SIBS Multibanco extra config

`opp_copyandpay_sibs_multibanco` adds: `pa_expiration_period` (int seconds, default 3600),
`sibs_payment_entity` (string, provided by SIBS). Default `test_mode` is `EXTERNAL`; brand is forced to
`SIBS_MULTIBANCO`; brand select is hidden. It implements `HasPaymentInstructionsInterface`
(`buildPaymentInstructions()` renders the `sibs_multibanco_instructions` theme with `pmt_ref`), sends
`customParameters[SIBSMULTIBANCO_*]` on `prepareCheckout()`, and stores the payment reference (`pmt_ref` field)
from `resultDetails.pmtRef` when the acquirer response is `APPR`.

### SOFORT Überweisung extra config

`opp_copyandpay_sofortueberweisung` adds `sofort_countries` (sequence) and `sofort_restrict_billing` (bool) —
restricts selectable countries, optionally to the billing address country.

## Global settings (`commerce_opp.settings`)

Form `CommerceOppSettingsForm` at `/admin/commerce/config/payment/opp` (route `commerce_opp.settings`,
perm `administer commerce_payment_gateway`; menu link under *Commerce → Configuration → Payment*):

- `encryption_secret` (string) — only shown/used when `commerce_opp_webhooks` is enabled; the AES-256-GCM key
  for decrypting webhook notifications. Store as a protected secret.
- `cron_expiration_threshold` (int seconds, default 86400) — extra lifetime added when computing which `new`
  payment intents cron should still process vs. delete.

Install defaults in `config/install/commerce_opp.settings.yml` (`encryption_secret: ''`,
`cron_expiration_threshold: 86400`).

## Widget & offsite form

`PluginForm\CopyAndPayForm` (offsite form for all plugins) builds the payment: sets the payable amount
(`getPayableAmount()`), calls `prepareCheckout()` to obtain a checkout ID, then attaches the OPP
`paymentWidgets.js?checkoutId=…` script (library `commerce_opp/init`, `js/opp.init.js`) and renders the
COPYandPAY widget (`class="paymentWidgets" data-brands="…"`). Saved-method reuse adds
`registrations[0].id` + `standingInstruction.*` params. `CopyAndPayMbwayForm` is the MB WAY variant.
