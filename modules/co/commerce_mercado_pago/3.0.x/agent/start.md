<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_mercado_pago — agent start

Adds a **Mercado Pago Checkout Pro** payment gateway to **Drupal Commerce** (Latin America:
AR, BR, CL, CO, MX, PE, UY). Offsite gateway — the customer is redirected to Mercado Pago to
pay and returns to the store. Depends on `commerce:commerce_payment`; requires the Mercado Pago
PHP SDK `mercadopago/dx-php:^3` (pulled by Composer). Core `^9 || ^10 || ^11`. Version `3.0.0-rc3`.
Not covered by Drupal's security advisory policy.

## What it ships
- **One payment gateway plugin**: `mercado_pago_checkout_pro`
  (`CheckoutPro`, extends `OffsitePaymentGatewayBase`, implements `SupportsRefundsInterface`).
- **One payment method type**: `mercado_pago_checkout_pro` (`MercadoPagoCheckoutPro`, extends
  Commerce `CreditCard`; label falls back to "Mercado Pago" when no `card_type`).
- **One offsite plugin form**: `RedirectCheckoutForm` (builds the MP *Checkout Preference* and
  redirects/opens the popup).
- **One custom controller/route**: `commerce_mercado_pago.checkout_popup_return`
  (`/commerce-mercado-pago/checkout-return`, `_access: 'TRUE'`) — intermediate page that closes
  the checkout popup and redirects the opener (same-origin-only, escaped).
- **Static data map**: `MercadoPagoPaymentMethodsMap` — country → payment type → method labels/ids,
  drives the config form and the preference's exclusion lists.
- **JS libraries**: `checkout_popup` (popup open), `mp_sdk` (MP SDK v2), `checkout_pro_review`
  (legacy Wallet script, currently unused). `gateway_admin` CSS toggles credential fieldsets by mode.

**No** `.install`, `.module`, `.services.yml`, `.permissions.yml`, or hook_update. No new plugin
*types*. No dedicated settings route — configured on Commerce's own payment-gateways admin.

## Where it is configured
`/admin/commerce/config/payment-gateways` (permission `administer commerce payment gateway`) → add a
gateway of plugin **Mercado Pago CheckoutPro**. Stored as a
`commerce_payment.commerce_payment_gateway.plugin.mercado_pago_checkout_pro` config entity.

Three modes: `test` (Sandbox – test account), `stage` (production account + test credentials),
`live` (production account + production credentials). Each mode has its own `public_key_*` /
`access_token_*` pair. See config keys and the payment flow in
[gateway.md](gateway.md).

## Payment flow (offsite)
1. `RedirectCheckoutForm::buildConfigurationForm()` builds items/payer/shipments from the order,
   creates a Checkout **Preference** via `PreferenceClient::create()` with `binary_mode => TRUE`,
   `external_reference => order id`, `notification_url` = Commerce `commerce_payment.notify`, and
   `excluded_payment_methods`/`excluded_payment_types` derived from gateway config. Redirects (or
   opens a popup) to `preference->init_point`.
2. **onNotify()** (IPN, `commerce_payment.notify`): re-fetches payment/merchant order from the MP API
   by id, binds via `external_reference`, records/refunds the Commerce payment.
3. **onReturn()** (browser return): re-fetches the payment from the MP API, requires API status
   `approved`, binds via merchant-order `external_reference`, records the payment.
4. **refundPayment()**: `PaymentRefundClient` total/partial refund; sets `refunded`/`partially_refunded`.

Both callback paths derive the outcome from Mercado Pago's authenticated API (re-fetch by id), not from
forgeable request parameters; the return path also binds the payment to the order via
`external_reference`. Store the access token/client secret as secrets (env/Key) and serve over HTTPS.

- **Gateway plugin: config keys, modes, country/method map, callbacks, refunds** → [gateway.md](gateway.md)

## Limitation for evals / sandbox
Live behaviour (preference creation, IPN, return verification, refunds) requires real MP credentials
and outbound network to `api.mercadopago.com`. In a dev/sandbox you can create and introspect the
**gateway config entity** (plugin id + mode + credential keys + country/method selection) but cannot
complete a real transaction.
