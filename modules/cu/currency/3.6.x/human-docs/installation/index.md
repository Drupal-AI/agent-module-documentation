# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Plugin** module (`drupal/plugin` `^2.6`), pulled in by Composer.
- Two PHP libraries, also pulled in by Composer:
  - **commercie/currency** (`~1.3`) — the currency data and input parser.
  - **commercie/currency-exchange** (`~1.0`) — the exchange-rate framework.
- The **`bcmath`** PHP extension, which Currency uses for exact money arithmetic.
  Make sure it is enabled in your PHP build. (DDEV's default PHP images include it.)

## Install with Composer

From the project root:

```bash
composer require drupal/currency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Plugin module
and the `commercie/*` libraries, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/currency -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. To confirm the `bcmath`
> extension is available, run `ddev exec php -m | grep bcmath`.

## Enable the module

```bash
drush en currency -y
```

Optionally enable the internationalization submodule for localized currency names:

```bash
drush en currency_intl -y
```

## Right after install

Only the placeholder currency `XXX` and the `en_US` formatting locale are enabled
on a fresh install. Your first real task is to **import the currencies you need** —
see [Configuration](../configuration/index.md). Until you import at least one
currency (and, for conversions, define at least one exchange rate), there is little
for the module to display.
