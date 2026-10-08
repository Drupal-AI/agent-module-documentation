# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) enabled — this is the only module dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cookie_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_cookie_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cookie_condition -y
```

## Verify it worked

Edit a promotion at **Commerce → Promotions**, open its **Conditions** section,
and add a condition. **Current user has cookie** should appear under the
**Customer** category. See "How to use it" in the [overview](../index.md) for the
cookie name and value fields.
