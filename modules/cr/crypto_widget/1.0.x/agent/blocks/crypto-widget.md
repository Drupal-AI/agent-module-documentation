<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Crypto widget" block

## Install & enable

```bash
composer require drupal/crypto_widget
drush en crypto_widget -y
```

No dependencies outside Drupal core. No sub-modules, no permissions of its own, no Drush
commands, no `.install` file.

## Place the block

UI path: *Structure → Block layout* (`/admin/structure/block`) → **Place block** in a region →
choose **Crypto widget** (category *Widget*) → set the options below → **Save block**. Placing
and configuring the block uses core's normal *Administer blocks* permission
(`administer blocks`); the module adds no permission of its own.

## Block settings

Defined in `blockForm()` / stored in `blockSubmit()` (`src/Plugin/Block/CryptoWidget.php`):

| Setting key | Type | Options | Meaning |
|---|---|---|---|
| `crypto_widget` | select | BTC, ETH, USDT, ADA, BCH, LTC, UNI, LINK, ETC, XLM, USDC, FIL, WBTC, BSV, ATOM, DASH | The coin ticker to price. |
| `currency` | select | EUR, USD | Fiat currency of the quote. |
| `period` | select | 5, 10, 30, 60 | Auto-refresh interval in **minutes**. |
| `options` | string | (derived) | Human-readable coin label; set automatically in `blockSubmit()` from a fixed code→name map, not shown as a form field. |

`blockSubmit()` looks up `$tokens[$values['crypto_widget']]` to fill `options`, so the coin
select is effectively required (leaving it empty would produce an undefined-index notice).

Config schema for these keys is in `config/schema/crypto_widget.schema.yml` under
`block.settings.crypto_widget` (all four typed as `string`).

### Example block config export

```yaml
# block.block.cryptowidget.yml (settings excerpt)
settings:
  id: crypto_widget
  label: 'Crypto widget'
  provider: crypto_widget
  crypto_widget: BTC
  currency: USD
  period: '30'
  options: Bitcoin
```

## Rendering & theme

`build()` returns:

```php
[
  '#theme' => 'crypto_widget',
  '#ticket' => $config['crypto_widget'],
  '#token_label' => $config['options'],
  '#currency' => $config['currency'],
  '#period' => $config['period'],
  '#attached' => ['library' => 'crypto_widget/widget'],
];
```

Theme hook `crypto_widget` is registered by `crypto_widget_theme()` with variables `ticket`,
`token_label`, `currency`, `period`. Template `templates/crypto-widget.html.twig` outputs a
`.widget` element carrying `data-crypto-ticket`, `data-crypto-currency` and `data-crypto-period`
attributes, plus placeholder spans (`.crypto-widget-price`, `.crypto-widget-change`,
`.crypto-widget-change-day`, `.crypto-widget-change-week`, `.crypto-widget-date`) that the JS
fills in. All values are printed through Twig auto-escaping. Override the template or
`css/widget.css` in your theme to restyle.

## Client-side behavior (`js/widget.js`)

`Drupal.behaviors.cryptoWidget` (guarded by `core/once` on `.block-crypto-widget`):

1. Reads the coin, currency and period from the `data-crypto-*` attributes; adds an
   `icon-{coin}` class (icomoon font) to the icon span.
2. Builds three URLs:
   - `https://api.coinbase.com/v2/prices/{COIN}-{CURRENCY}/spot` (current spot),
   - the same with `?date=<yesterday>` (1-day change),
   - the same with `?date=<7 days ago>` (7-day change).
3. Calls `getData()` immediately and again every `period × 60 × 1000` ms via `setInterval`.
4. `getData()` uses `fetch()` → `res.json()`, reads `data.data.amount`, writes the current
   price, computes percentage variation vs. the last polled price (period change), vs. the
   1-day and 7-day historical amounts, and stamps the current date/time. Positive changes get a
   `value-positive` CSS class. Errors are swallowed with `.catch(error => console.log(error))`.

There is **no server-side request** and **no API key**: the browser talks directly to Coinbase's
public price endpoint over HTTPS. The coin and currency come from the fixed select lists above,
so the request path is not attacker-controlled.

## Supported coins (help text / form options)

Bitcoin (BTC), Ethereum (ETH), Tether (USDT), Cardano (ADA), Bitcoin Cash (BCH), Litecoin (LTC),
Uniswap (UNI), Chainlink (LINK), Ethereum Classic (ETC), Stellar (XLM), USD Coin (USDC),
Filecoin (FIL), Wrapped Bitcoin (WBTC), Bitcoin SV (BSV), Cosmos (ATOM), Dash (DASH).

## Gotchas

- Price display depends on the visitor's browser being able to reach `api.coinbase.com`; if the
  request fails the placeholders stay empty (errors only go to the console).
- The refresh is client-side only — the block itself is fully cacheable; new prices come from the
  interval poll, not from re-rendering the block.
- Only EUR and USD are offered; the Coinbase endpoint supports more, but the form does not.
- Icons come from a bundled icomoon font (`css/fonts/`); the icon class is `icon-{coin-lowercase}`.
