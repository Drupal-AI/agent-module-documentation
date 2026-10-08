# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- No external modules or libraries — Publish Guard works with Drupal core alone.

## Install with Composer

From the project root:

```bash
composer require drupal/publish_guard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/publish_guard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publish_guard -y
```

The module is **disabled by default** — enabling it does not yet impose any
restrictions. You turn restrictions on and define the schedule on the settings
page.

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring →
Publish Guard** (`/admin/config/content/publish-guard`). You should see the
settings form with an **Enable publishing restrictions** checkbox. From here,
follow [Configuration](../configuration/index.md) to set your allowed days,
daily window, and enforcement mode.
