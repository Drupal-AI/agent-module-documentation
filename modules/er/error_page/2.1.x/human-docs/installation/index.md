# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules, no third-party Composer packages, and no PHP library
  requirements. The module has no dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/error_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Installing via Composer is recommended because the module's error
handler class is class-mapped in its `composer.json`, so it autoloads even before Drupal's
container has booted — which matters for catching very early failures.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/error_page -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en error_page -y
```

Enabling the module is all you need for the **uncaught exception** case — the friendly
500 page takes over automatically, with no configuration. To also cover **fatal and
user-level PHP errors**, and to customize the page, continue to
[Configuration](../configuration/index.md).

There are no submodules for production use. A bundled `error_page_test` module exists purely
for triggering test errors during development — never enable it in production.
