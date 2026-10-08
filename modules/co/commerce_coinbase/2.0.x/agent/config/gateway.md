<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway config, off-site charge creation & API service

## Install / enable

```bash
composer require drupal/commerce_coinbase
drush en commerce_coinbase -y
```

Pulls in only `commerce` + `commerce_payment` (both part of Drupal Commerce). No external library,
cURL check, or cron is required by 2.0.x.

## The payment gateway plugin

`src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`

```
@CommercePaymentGateway(
  id = "coinbase_offsite",
  label = "Coinbase (Off-site)",
  display_label = "Coinbase",
  forms = { "offsite-payment" = "...\PluginForm\OffsiteRedirect\PaymentOffsiteForm" },
  payment_method_types = {"crypto_wallet"},
  requires_billing_information = FALSE,
)
```

Extends `OffsitePaymentGatewayBase`. Add it at
**Commerce → Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`).

`buildConfigurationForm()` fields (stored on the gateway config entity; schema
`config/schema/commerce_coinbase.schema.yml` declares `api_key` and `secret` as `string`):

| field | notes |
|-------|-------|
| `api_key` | Coinbase Commerce API key (`X-CC-Api-Key`). `#required`. |
| `secret` | Webhook **shared secret** used for HMAC verification. `#required`. |
| `charge_name` | Charge name (≤100 chars), token-enabled. Default `Order #[commerce_order:order_id]`. |
| `charge_description` | Charge description (≤200 chars), token-enabled. Default `Order #[commerce_order:order_id] at [site:name]`. |

The form also renders a read-only **Webhook endpoint** item. Note it builds that URL with a
hardcoded gateway id `'coinbase'` (`Url::fromRoute('commerce_coinbase.webhook',
['commerce_payment_gateway' => 'coinbase'], ['absolute' => TRUE])`), so the displayed URL is only
correct when the gateway's machine name is literally `coinbase`; the actual route accepts any
`{commerce_payment_gateway}`. `submitConfigurationForm()` persists the four values.

`onReturn(OrderInterface $order, Request $request)` is an **empty stub** (only commented example
code). The shopper returning from Coinbase does not finalize anything — fulfilment happens only when
the signed webhook arrives (see [../webhook.md](../webhook.md)).

## Off-site redirect form (charge creation)

`src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php::buildConfigurationForm()`:

1. If the order has no order number yet, it generates one from the order type's number pattern (or
   falls back to the order id) and saves the order.
2. Resolves `charge_name` / `charge_description` from gateway config and runs them through
   `token->replace()` with the `commerce_order` context.
3. `client->setApiKey($api_key)` then builds the charge params:
   - `name`, `description` (truncated to 100 / 200 chars)
   - `pricing_type: 'fixed_price'`
   - `local_price: { amount: $payment->getAmount()->getNumber(), currency: <currency code> }`
   - `metadata: { customer_id, order_id, order_number }` — **`order_id` here is what the webhook
     later reads back** to bind the payment to the order.
   - `redirect_url: $form['#return_url']`, `cancel_url: $form['#cancel_url']`
4. `client->createCharge($params)` → uses the returned `hosted_url` as the redirect target; throws
   `Exception('Error create payment')` if absent. Builds the redirect form and unsets the
   auto-submit JS library (`$form['#attached']['library']`).

## API service (`commerce_coinbase.api` → `src/CoinbaseApi.php`)

Constructor args (`commerce_coinbase.services.yml`): `@http_client`, `@logger.factory`, `@database`,
`@current_user`, `@request_stack`.

- `setApiKey($apikey)` — stores the key for the next call.
- `createCharge($params)` — validates params (`validateChargeParams()` via Symfony `Validation`),
  then `POST https://api.commerce.coinbase.com/charges` with headers
  `X-CC-Api-Key: <key>`, `X-CC-Version: 2018-03-22`, JSON body `$params`. Guzzle default TLS
  verification (no `verify => false`). Logs and rethrows on `ClientException`; throws on non-201 or
  empty response. Returns the decoded `data` object (contains `hosted_url`, `code`, etc.).
- `validateChargeParams()` / `validateCheckoutParams()` — Symfony `Assert\Collection` constraints
  (name/description length, `pricing_type` choice, positive amount, 3-char currency, optional
  `redirect_url`/`cancel_url` must be URLs). On violation it logs and returns FALSE (charge not sent).
- `log($url, $type, $data, $log_parameters)` — inserts a row into `commerce_coinbase_log`
  (uid, client IP hostname, created, url, type, serialized data, order_id). Swallows its own
  exceptions.

## Payment method type

`src/Plugin/Commerce/PaymentMethodType/CryptoWallet.php` — `@CommercePaymentMethodType(id =
"crypto_wallet")`. Adds `crypto_type` and `crypto_number` string bundle fields. Largely a stub:
`buildLabel()` returns "CryptoWallet ending in 123" (the card number is hardcoded in source).

## Log table

`commerce_coinbase.install` defines `commerce_coinbase_log` (serial id; uid; url varchar(1000);
order_id; type e.g. `request`/`response`/`webhook:<type>`; hostname; created; `data` big blob of
serialized request/response). There is no admin UI to read it; it is a raw debug/audit trail.
