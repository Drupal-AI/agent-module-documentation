<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce Square

Two layers of configuration: **application settings** (one config object, shared) and
**per-gateway settings** (on each `commerce_payment_gateway` entity of plugin `square`).

## Application settings — `commerce_square.settings`

Form `SquareSettings` (`ConfigFormBase`) at route **`commerce_square.settings`** →
`/admin/commerce/config/square`, permission **`administer commerce square`**.

| Key | Label | Notes |
|---|---|---|
| `app_name` | Application Name | required |
| `app_secret` | Application Secret | OAuth application secret (production) |
| `sandbox_app_id` | Sandbox Application ID | required for sandbox testing |
| `sandbox_access_token` | Sandbox Access Token | required for sandbox testing |
| `production_app_id` | Application ID (production) | required; used as OAuth `client_id` |

```bash
drush cget commerce_square.settings
drush cset commerce_square.settings sandbox_app_id 'sandbox-sq0idb-XXXX' -y
drush cset commerce_square.settings sandbox_access_token 'EAAA…' -y
```

### Production OAuth (where production tokens go)

Submitting the settings form redirects the merchant to `https://squareup.com/oauth2/authorize`
with the `production_app_id` and the scope `MERCHANT_PROFILE_READ PAYMENTS_READ PAYMENTS_WRITE
CUSTOMERS_READ CUSTOMERS_WRITE ORDERS_WRITE`. Square redirects back to
`/admin/commerce_square/oauth/obtain` (route `commerce_square.oauth.obtain`) with a `code`,
which the form exchanges for tokens. Those tokens are written to **Drupal state**, not config:

- `commerce_square.production_access_token`
- `commerce_square.production_refresh_token`
- `commerce_square.production_access_token_expiry`

```bash
drush sget commerce_square.production_access_token
```

Sandbox uses `sandbox_access_token` from config directly — no OAuth needed for sandbox.

## Per-gateway settings — the `square` payment gateway entity

Create a payment gateway at *Commerce → Configuration → Payment gateways* choosing plugin
**Square**. Config is stored on the `commerce_payment_gateway` config entity
(`commerce_payment.commerce_payment_gateway.<id>`). Plugin settings (see schema
`commerce_payment.commerce_payment_gateway.plugin.square`):

| Setting | Default | Meaning |
|---|---|---|
| `test_location_id` | `''` | Square Location for Sandbox transactions |
| `live_location_id` | `''` | Square Location for Production transactions |
| `enable_credit_card_icons` | `TRUE` | show card-brand icons at checkout |
| `mode` | `test` | `test` (Sandbox) or `live` (Production) — standard Commerce gateway key |

The Location select options are fetched **live** from Square's Locations API when you open the
gateway form; without valid credentials/network the select is disabled and shows
"Not configured".

### Create a gateway with drush php:eval

```php
\Drupal\commerce_payment\Entity\PaymentGateway::create([
  'id' => 'square_test',
  'label' => 'Square (sandbox)',
  'plugin' => 'square',
  'configuration' => [
    'mode' => 'test',
    'test_location_id' => 'L_TEST_123',
    'live_location_id' => '',
    'enable_credit_card_icons' => TRUE,
  ],
])->save();
```

Read it back: `drush cget commerce_payment.commerce_payment_gateway.square_test`.
