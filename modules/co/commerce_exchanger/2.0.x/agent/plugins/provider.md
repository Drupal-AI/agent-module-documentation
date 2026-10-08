<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an exchange-rate provider plugin

Plugin type id: **`commerce_exchanger_provider`** (manager
`plugin.manager.commerce_exchanger_provider` / `ExchangerProviderManager`).

- Namespace: `Plugin\Commerce\ExchangerProvider` (i.e.
  `src/Plugin/Commerce/ExchangerProvider/`).
- Identify with the PHP attribute
  `Drupal\commerce_exchanger\Attribute\CommerceExchangerProvider` (legacy annotation
  `Drupal\commerce_exchanger\Annotation\CommerceExchangerProvider` also supported).
- Base classes: `ExchangerProviderBase` (manual) or `ExchangerProviderRemoteBase`
  (remote APIs — implements the HTTP client, sync loop, cross-sync and transform logic
  for you).

## Attribute properties

```php
#[CommerceExchangerProvider(
  id: "my_bank",
  label: new TranslatableMarkup("My National Bank"),
  display_label: new TranslatableMarkup("My National Bank"),
  base_currency: "EUR",     // set when the source is locked to one base (like ECB)
  modes: FALSE,             // supports test/live mode
  api_key: FALSE,           // requires an API key field
  auth: FALSE,              // requires username/password
  enterprise: FALSE,        // can fetch by any base currency
  refresh_once: TRUE,       // provider updates only once/day
  manual: FALSE,            // manual (no external fetch)
  method: "GET",            // HTTP method
  transform_rates: FALSE,   // ratios are reversed (target->source); invert them
)]
```

Notes: setting `base_currency` disables enterprise mode — non-base pairs are then derived
by cross conversion. `transform_rates: TRUE` when the API returns reverse ratios.

## For a remote provider, implement two methods

Extend `ExchangerProviderRemoteBase` and implement:

```php
public function apiUrl() {
  return 'https://api.example.com/latest?base=' . $this->getBaseCurrency();
}

public function getRemoteData($base_currency = NULL) {
  $body = $this->apiClient([]);      // provided by the base: performs the HTTP request
  // Parse and return a rates array in EITHER accepted shape:
  //   ['HRK' => '1.3', 'USD' => '1.666']                      // flat, keyed by target
  //   ['base' => 'USD', 'rates' => ['HRK' => '1.3', ...]]     // with explicit base
  return $data;
}
```

If `getRemoteData()` returns one of those two shapes, the base class handles storing,
cross-sync, transform, and cron scheduling — you implement nothing else. The base also
exposes `getApiKey()`, `getAuthData()`, `isEnterprise()`, `getBaseCurrency()`,
`useCrossSync()`, `transformRates()`, `getMethod()` reading from the entity's
`configuration`.

## Manual provider

A manual plugin just extends `ExchangerProviderBase` with `manual: TRUE` and no body (see
`ManualExchanger`) — rates are entered/maintained in the UI or written via
`commerce_exchanger.manager::setLatest()`.

Real examples to copy: `EuropeanCentralBankExchanger` (XML), `FixerExchanger`,
`OpenExchangeRatesExchanger`, `TransferWiseExchanger`, and the contrib
`commerce_exchanger_hnb` / `commerce_exchanger_nbu` projects.
