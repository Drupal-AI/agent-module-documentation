# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drupal Commerce** with the **Commerce Payment** module
  (`commerce_payment`) enabled — this is a hard dependency, and Composer will pull
  in Commerce as needed.
- A **NoFraud account** and a valid **API key** for the environment you intend to
  use (Sandbox for testing, Production for live orders).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nofraud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce and other
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nofraud -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nofraud -y
```

## Verify it worked

After enabling, go to **Commerce → Configuration → NoFraud**
(`/admin/commerce/config/nofraud`). If the settings form loads, the module is
active — but it will not screen any orders until you enter a valid API key and
choose a mode. Continue to [Configuration](../configuration/index.md).
