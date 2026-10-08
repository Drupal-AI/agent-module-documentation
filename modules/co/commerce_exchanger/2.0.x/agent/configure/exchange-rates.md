<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange rates config entity + storage

There is **no settings form** and `configure` is `null`. Each rate source is a
`commerce_exchange_rates` config entity. Manage them at
*Commerce → Configuration → Exchange rates* (`/admin/commerce/config/exchange-rates`,
routes `entity.commerce_exchange_rates.collection` / `.add_form` / `.edit_form` /
`.delete_form`). Permission: `administer commerce exchanger settings`.

## The config entity

Config name: `commerce_exchanger.commerce_exchange_rates.<id>`. Exported keys
(`config_export`): `id`, `label`, `plugin`, `configuration`.

```yaml
id: my_rates
label: 'My rates'
plugin: manual          # provider plugin id
configuration:          # schema type = plugin's configuration, see below
  manual: true
  refresh_once: false
  cron: 0
  use_cross_sync: false
  base_currency: USD
  mode: live
  enterprise: false
  transform_rates: false
  historical_rates: false
```

`configuration` conforms to schema `commerce_exchanger_provider_configuration`
(keys: `api_key`, `auth.username`/`auth.password`, `cron`, `use_cross_sync`,
`base_currency`, `demo_amount`, `mode`, `enterprise`, `manual`, `refresh_once`,
`transform_rates`, `historical_rates`). Which keys are relevant depends on the provider
plugin's attribute flags (`api_key`, `auth`, `enterprise`, `base_currency`, …).

## Built-in provider plugins (`plugin:` value)

| id | class | notes |
|---|---|---|
| `manual` | ManualExchanger | you type/maintain rates; no external fetch |
| `ecb` | EuropeanCentralBankExchanger | base `EUR`, `refresh_once`, no key |
| `fixer` | FixerExchanger | needs `api_key` |
| `currencylayer` | CurrencylayerExchanger | needs `api_key` |
| `open_exchange_rates` | OpenExchangeRatesExchanger | needs `api_key` |
| `transferwise` | TransferWiseExchanger | mid-market rates |

## Create via drush php:eval (scriptable, no UI)

```php
use Drupal\commerce_exchanger\Entity\ExchangeRates;
ExchangeRates::create([
  'id' => 'my_rates', 'label' => 'My rates', 'plugin' => 'manual',
  'configuration' => [
    'manual' => TRUE, 'refresh_once' => FALSE, 'cron' => 0,
    'use_cross_sync' => FALSE, 'base_currency' => 'USD', 'mode' => 'live',
    'enterprise' => FALSE, 'transform_rates' => FALSE, 'historical_rates' => FALSE,
  ],
])->save();
```

## Read it back

```bash
drush cget commerce_exchanger.commerce_exchange_rates.my_rates
drush config:status | grep commerce_exchange_rates
# PHP: \Drupal\commerce_exchanger\Entity\ExchangeRates::load('my_rates')->get('plugin')
```

## Actions

- The collection page shows **"Run import"** (`commerce_exchanger.import`,
  `/admin/commerce/config/exchange-rates/import`) which invokes
  `commerce_exchanger.import` (`DefaultExchangerImporter`) to fetch remote rates now.
- Remote providers also import on cron (throttled by the `cron` / `refresh_once` settings).

## Rates are NOT in config

The exported entity only holds the provider config. Actual numeric rates live in the
`commerce_exchanger_latest_rates` (and `commerce_exchanger_historical_rates`) DB tables —
see [../api/services.md](../api/services.md).
