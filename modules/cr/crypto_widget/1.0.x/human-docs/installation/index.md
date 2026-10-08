# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No modules outside of Drupal core, and no third‑party PHP or Composer libraries.
- The block relies on core JavaScript libraries (`core/drupal`, `core/jquery`,
  `core/once`, `core/drupalSettings`), which ship with Drupal.

Because prices are fetched from Coinbase in the visitor's browser, visitors need
outbound access to Coinbase's public price endpoint for the value to update.

## Install with Composer

From the project root:

```bash
composer require drupal/crypto_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crypto_widget -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crypto_widget -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm that
**Crypto widget** appears in the list. Place it in a region, pick a coin and
currency, save, and load a front‑end page — the current price should appear and
update on the interval you chose. See the
[main guide](../index.md#how-to-use-it) for the block configuration steps.
