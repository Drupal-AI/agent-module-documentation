# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — the module's only declared dependency is Commerce's
  **Price** module (`commerce_price`). In practice you also want the **Product**
  module (`commerce_product`) enabled, since the formatters attach to a product's
  Variations field.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_from_price -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_from_price -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_from_price -y
```

## Verify it worked

Go to **Commerce → Configuration → Product types → *(a product type)* → Manage
display** and open the format dropdown for the **Variations** field. You should
see the new "from" price formatters in the list. Pick one and save — see the
[main guide](../index.md#how-to-use-it) for the details, including how to add a
"Starting at" label.
