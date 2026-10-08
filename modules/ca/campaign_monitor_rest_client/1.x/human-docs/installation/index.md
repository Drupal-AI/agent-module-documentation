# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Campaign Monitor account** and an **API key** for it.
- No other module dependencies. (The companion webform handler module depends on
  *this* module, not the other way around.)

## Install with Composer

From the project root:

```bash
composer require drupal/campaign_monitor_rest_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/campaign_monitor_rest_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en campaign_monitor_rest_client -y
```

After enabling, provide your Campaign Monitor API key — see
[Configuration](../configuration/index.md).
