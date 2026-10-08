# Commerce Braintree — gateway configuration

## Add the gateway

*Commerce → Configuration → Payment → Payment gateways → Add* → plugin **"Braintree (Hosted Fields)"**
(`braintree_hostedfields`). There is no separate module settings page; everything is on this
`commerce_payment_gateway` config entity. Set **Mode** to *Test* (Braintree sandbox) or *Live*.

## Settings (schema `...plugin.braintree_hostedfields`)

| Field | Key | Notes |
|---|---|---|
| Merchant ID | `merchant_id` | Braintree account merchant id (required). |
| Public key | `public_key` | Braintree API public key (required). |
| Private key | `private_key` | Braintree API private key (required). |
| Merchant account ID | `merchant_account_id` | **Per-currency map**: one required field per enabled Commerce currency; value = the Braintree merchant account id for that currency. |
| 3D Secure | `3d_secure` | `''` (Disabled), `enabled`, or `required`. |
| Enable Credit Card Icons | `enable_credit_card_icons` | Show card-brand icons at checkout (default TRUE). |

Keys are read into the SDK in `HostedFields::init()`:
`environment = (mode == 'test') ? 'sandbox' : 'production'`, plus merchantId/publicKey/privateKey. The
gateway re-inits on `__wakeup()`.

> Deployment note: the private key is stored on the config entity like any Commerce gateway credential;
> override it out of exported config via `settings.php` (`$config[...]`) / env if you don't want it in
> the sync directory. (Standard Commerce practice — not a module-specific issue.)

## Payment method types

`credit_card`, `paypal`, and `paypal_credit` (a dedicated type so PayPal Credit is its own checkout
option, class `PayPalCredit` adds a `paypal_mail` field). Enable the ones you want in Braintree and in
the store's checkout.

## Multiple currencies

`getMerchantId($currency_code)` looks up `merchant_account_id[$currency_code]`; if a currency has no
mapped merchant account it throws `InvalidArgumentException` (surfaced as a `PaymentGatewayException`).
Configure a Braintree merchant account per currency your store accepts, or Braintree will charge in the
account's default currency.

## 3-D Secure 2

Set `3d_secure` to `enabled` or `required`, then add the **Braintree 3DS review** checkout pane
(`braintree_3ds_review`) to the checkout flow's **review** step
(*Commerce → Configuration → Checkout flows*). The pane runs client-side 3DS authentication (Braintree
`three-d-secure` JS) before the final submit; unenrolled cards pass through normally. It is required for
3DS to work with vaulted/stored payment methods.

## Operations (for reference)

`createPayment` (transaction sale; `capture=false` → authorization only), `capturePayment`
(`submitForSettlement`), `voidPayment`, `refundPayment` (voids instead when the txn isn't settled yet —
Braintree error code `91506`), `createPaymentMethod` / `deletePaymentMethod` (vaults with
`verifyCard = true`; creates a Braintree customer for authenticated owners).

## Frontend libraries

Braintree web SDK v3.92.1 is loaded externally from `js.braintreegateway.com` with SRI `integrity`
hashes (`commerce_braintree.libraries.yml`): `braintree` (client), `hosted-fields`, `three-d-secure`,
`paypal-checkout`.
