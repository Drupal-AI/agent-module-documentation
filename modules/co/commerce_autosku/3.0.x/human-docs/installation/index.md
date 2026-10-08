# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** (`commerce`, providing `commerce_product`) version 2 or 3.
- The **Token** module (`token`) version 1.
- The PHP `mbstring` extension (`ext-mbstring`), which is standard on almost all
  Drupal hosts.

Drupal enables the `commerce_product` and `token` dependencies automatically
when you turn on Commerce AutoSKU.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_autosku -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update
Commerce, Token, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_autosku -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_autosku -y
```

The module ships no submodules. Once enabled, configure SKU generation per
product variation type — see [Configuration](../configuration/index.md).
