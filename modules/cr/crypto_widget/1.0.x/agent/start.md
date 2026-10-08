<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crypto Widget (crypto_widget) — agent index

A block that displays the live spot price of one chosen cryptocurrency, fetched **client-side**
from the public **Coinbase** API. Package: none declared (`info.yml` sets no `package`).
No dependencies outside Drupal core. Core requirement `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.x (packaged 1.0.2).

- **The block plugin, its settings, theme hook, JS/CSS library, and how to place it** →
  [blocks/crypto-widget.md](blocks/crypto-widget.md)

## What it actually is

- One block plugin: `CryptoWidget` (id **`crypto_widget`**, admin label *"Crypto widget"*,
  category *"Widget"*), in `src/Plugin/Block/CryptoWidget.php`, extending core `BlockBase`.
- One theme hook: `crypto_widget` (`crypto_widget_theme()` in `crypto_widget.module`), template
  `templates/crypto-widget.html.twig`, variables `ticket`, `token_label`, `currency`, `period`.
- One asset library: `crypto_widget/widget` (`crypto_widget.libraries.yml`) → `js/widget.js`,
  `css/widget.css`, an icomoon icon font under `css/fonts/`; depends on `core/drupal`,
  `core/jquery`, `core/once`, `core/drupalSettings`.
- One `hook_help()` implementation (help.page.crypto_widget) listing supported coins.
- Config schema for the block settings only (`config/schema/crypto_widget.schema.yml`,
  key `block.settings.crypto_widget`).

## What it does NOT provide

- **No** routes, controllers, forms (beyond the block config form), services, or event
  subscribers. **No** permissions, **no** Drush commands, **no** `.install` file, **no**
  submodules, **no** `config/install` defaults. **No** server-side HTTP request: all price
  fetching happens in the visitor's browser.

## Mechanism (from source)

- `blockForm()` renders three selects: **coin** (`crypto_widget`, 16 fixed options BTC…DASH),
  **currency** (EUR/USD), **period** (5/10/30/60 minutes).
- `blockSubmit()` maps the selected coin code to a human label via a fixed array and stores
  `crypto_widget`, `currency`, `period`, `options` (the label) in block configuration.
- `build()` returns a `#theme => 'crypto_widget'` render array passing those values as
  `#ticket`, `#token_label`, `#currency`, `#period` and attaches `crypto_widget/widget`.
- `js/widget.js` (`Drupal.behaviors.cryptoWidget`) reads `data-crypto-*` attributes from the
  template, builds `https://api.coinbase.com/v2/prices/{COIN}-{CURRENCY}/spot` (plus `?date=`
  variants for 1-day/7-day change), and updates the DOM with `fetch()` on load and on a
  `setInterval` of the configured period.

See [blocks/crypto-widget.md](blocks/crypto-widget.md) for settings keys, config export, and
theming/behavior details.
