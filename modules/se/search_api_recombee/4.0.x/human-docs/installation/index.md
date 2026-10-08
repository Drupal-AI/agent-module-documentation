# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`).
- The companion **Recombee** module (`recombee`), which tracks users and displays
  recommendations from the Recombee API. This backend indexes content; the Recombee
  module is what surfaces the results.
- A **Recombee account and database** (the hosted SaaS service) with API
  credentials.

There are no third-party Composer or PHP library requirements beyond the modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_recombee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_recombee -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_recombee -y
```

Enable the companion Recombee module too, so you can track users and render
recommendations:

```bash
drush en recombee -y
```

Once enabled, continue to [Configuration](../configuration/index.md).
