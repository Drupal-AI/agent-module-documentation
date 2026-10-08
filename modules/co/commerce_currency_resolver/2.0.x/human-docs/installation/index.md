# Installation

## Requirements

Commerce Currency Resolver extends Drupal Commerce 3:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **[Commerce](https://www.drupal.org/project/commerce)** `^3.2` — specifically its
  **Commerce Price** (`commerce_price`) and **Commerce Order** (`commerce_order`)
  submodules, which are required.
- **[Commerce Exchanger](https://www.drupal.org/project/commerce_exchanger)** `^2` —
  pulled in by Composer; it supplies exchange rates for automatic conversion.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_currency_resolver -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Commerce, Commerce
Exchanger, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_currency_resolver -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_currency_resolver -y
```

## Turn off the core Page Cache

This module relies on the **Internal Dynamic Page Cache** and is incompatible with the
core **Page Cache** module (which would serve one visitor's currency to everyone).
Disable Page Cache:

```bash
drush pmu page_cache -y
```

Leave Dynamic Page Cache enabled.

## Submodules — enable only what you need

The base module resolves prices, but *which* currency each visitor sees (and some
conversion wiring) comes from these optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Exchanger** | `commerce_currency_resolver_exchanger` | Wires in automatic exchange‑rate conversion and unlocks the **auto** / **combo** currency‑source options and the exchange‑rate provider selector on the settings form. Enable this if you want any automatic conversion. |
| **Cookie** | `commerce_currency_resolver_cookie` | Remembers a shopper's chosen currency in a cookie, and provides a front‑end currency‑switcher block. |
| **Language** | `commerce_currency_resolver_language` | Chooses the currency from the interface language, using a language‑to‑currency mapping you configure. |
| **GeoIP** | `commerce_currency_resolver_geoip` | Chooses the currency from the visitor's country via the GeoIP module. |
| **Smart IP** | `commerce_currency_resolver_smart_ip` | Chooses the currency from the visitor's country via the Smart IP module. |
| **Shipping** | `commerce_currency_resolver_shipping` | Keeps shipping rates correct in the resolved currency (per‑currency flat rates or auto‑conversion). |

You can combine several resolvers — for example cookie choice taking priority over
GeoIP, which takes priority over language — and the first one that returns a currency
wins.

## Grant the permission

The module defines a single permission, **Administer currency settings**
(`administer commerce currency resolver settings`), at **People → Permissions**
(`/admin/people/permissions`). It governs the main settings form *and* all the
submodule mapping pages. Grant it to your store administrators:

```bash
drush role:perm:add administrator 'administer commerce currency resolver settings'
```

Next, configure the module — see [Configuration](../configuration/index.md).
