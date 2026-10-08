# Configure the Sermepa/Redsýs payment gateway

There is **no module settings form**. `commerce_sermepa` is a Commerce payment gateway plugin
(`@CommercePaymentGateway id = "commerce_sermepa"`); you configure it by creating a
**payment gateway** config entity.

UI: `/admin/commerce/config/payment-gateways` → *Add payment gateway* → plugin
"Sermepa/Redsýs". The extra fields come from
`Sermepa::buildConfigurationForm()`.

## Config entity & object

- Entity type: `commerce_payment_gateway`, plugin `commerce_sermepa`.
- Config object: `commerce_payment.commerce_payment_gateway.plugin.commerce_sermepa`
  (schema type `commerce_payment_gateway_configuration` extended by
  `config/schema/commerce_sermepa.schema.yml`).

## Plugin configuration keys

| Key | Form widget | Default | Meaning |
|-----|-------------|---------|---------|
| `merchant_name` | textfield (max 25) | `''` | Merchant/store name (`Ds_Merchant_MerchantName`). Required. |
| `merchant_code` | textfield (max 9) | `''` | FUC merchant code assigned by the bank. Required. |
| `merchant_group` | textfield (max 5) | `''` | Optional merchant group. |
| `merchant_password` | textfield (max 32) | `''` | **SHA-256 merchant secret key** (base64, from the Redsýs admin panel). Required. Used to sign requests and verify responses. |
| `merchant_terminal` | textfield (max 3) | `''` | Terminal number (`Ds_Merchant_Terminal`). Required. |
| `merchant_paymethods` | multi-select | `['C']` | Allowed payment methods (`SermepaApi::getAvailablePaymentMethods()`; `C` = card). Required. |
| `merchant_consumer_language` | select | `'001'` | Redsýs consumer language code; `001` = Spanish, `002` = English, `000` = dynamic (follow the current site language). |
| `currency` | select | `'978'` | Numeric ISO 4217 currency (`978` = EUR). Options are only the site's **enabled** `commerce_currency` entities whose numericCode Redsýs supports. |
| `transaction_type` | select | `'0'` | Redsýs transaction type (`SermepaApi::getAvailableTransactionTypes()`; `0` = authorization). Drives the resulting payment state (see below). |
| `instructions` | text_format | empty / `plain_text` | Rich-text shown at end of checkout (via `buildPaymentInstructions()`). |

Inherited from `OffsitePaymentGatewayBase` / `PaymentGatewayBase`: `display_label`,
`mode` (`test` / `live` — selects the Redsýs endpoint and is stored on each payment's `test`
flag), `collect_billing_information`. The plugin sets `requires_billing_information = FALSE`.

`transaction_type` → payment state (from `Sermepa::getStatusMapping()`): `0`→`completed`,
`1`/`2`/`7`/`8`/`O`/`P`/`Q`→`authorization`, `3`→`refunded`, `5`/`6`/`R`/`S`→`completed`,
`9`→`authorization_expired`.

## Create it with Drush / PHP

`merchant_password` is the Redsýs secret key. Prefer sourcing it from the environment rather than
hard-coding it in exported config.

```php
$gateway = \Drupal\commerce_payment\Entity\PaymentGateway::create([
  'id' => 'sermepa',
  'label' => 'Pay with card (Redsýs)',
  'plugin' => 'commerce_sermepa',
  'configuration' => [
    'mode' => 'test',                 // 'test' or 'live'
    'merchant_name' => 'My Shop',
    'merchant_code' => '999008881',   // FUC from the bank
    'merchant_terminal' => '1',
    'merchant_password' => getenv('REDSYS_SECRET_KEY'),
    'merchant_group' => '',
    'merchant_paymethods' => ['C'],
    'merchant_consumer_language' => '001',
    'currency' => '978',              // EUR
    'transaction_type' => '0',
    'instructions' => ['value' => '', 'format' => 'plain_text'],
    'display_label' => 'Sermepa/Redsýs',
    'collect_billing_information' => FALSE,
  ],
]);
$gateway->save();
```

Set a single value from Drush:

```bash
ddev drush cset commerce_payment.commerce_payment_gateway.plugin.commerce_sermepa \
  configuration.merchant_code 999008881 -y
```

Notes:
- The currency select only lists currencies you have enabled in Commerce; enable EUR
  (`ddev drush commerce:currency:import EUR` or via the UI) or the currency you need first.
- `test` mode posts to `https://sis-t.redsys.es:25443/sis/realizarPago`, `live` to
  `https://sis.redsys.es/sis/realizarPago`. The test and live secret keys differ.
