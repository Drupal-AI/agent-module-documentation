# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drupal Commerce** (`commerce`) enabled — this is the only module dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_configurable_order_total -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_configurable_order_total -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_configurable_order_total -y
```

## Verify it worked

Go to **Structure → Views**, edit a View, and click **Add** in the Footer
section. You should see **Commerce Configurable Order Total** available as an area
handler. From there, follow "How to use it" in the [overview](../index.md) to
wire it into your order summary.
