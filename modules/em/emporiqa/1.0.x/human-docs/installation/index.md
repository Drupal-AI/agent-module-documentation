# Installation

## Requirements

- **Drupal core 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **Drupal Commerce 2.40+ or 3.x**, including **Commerce Product**
  (`commerce_product`).
- Core **Node** (`node`).
- **PHP 8.1 or later**.
- An **Emporiqa account** — free to start (signup credit, no card required), with
  Google, Microsoft, GitHub, or email/password sign‑in.
- *Optional:* **Commerce Stock** if you want stock read from it.

The Commerce Product and Node dependencies are enabled automatically when you
enable the module; Drupal Commerce itself must already be installed on the site.

## Install with Composer

From the project root:

```bash
composer require drupal/emporiqa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emporiqa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emporiqa -y
```

## Verify it worked

With the module enabled, its Drupal‑side settings become available and its Drush
sync commands are registered. To confirm the commands are present:

```bash
drush list | grep emporiqa
```

Then continue with [Configuration](../configuration/index.md) to create an
Emporiqa account, set the signing secret, and sync your catalog.
