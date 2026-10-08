# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).

Cookie Block has no module dependencies and no third‑party PHP or JavaScript
library requirements. It builds on core's condition plugin and Block modules.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_block -y
```

There is no required configuration.

## Verify it worked

Go to **Structure → Block layout**, place or edit a block, and open its visibility
settings. You should see a new **Cookie** condition where you can enter a cookie
name and value. That confirms the module is active — see the "How to use it"
section in the [overview](../index.md) for setting up the condition.
