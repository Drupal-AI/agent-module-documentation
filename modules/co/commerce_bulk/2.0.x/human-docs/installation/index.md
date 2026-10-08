# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Drupal Commerce** with **Commerce Order** enabled (`commerce_order`).
- Core's **Action** (`action`) and **Taxonomy** (`taxonomy`) modules — Drupal
  enables these dependencies for you.
- **Devel** is optional and only needed by the **Commerce Generate** submodule.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_bulk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_bulk -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_bulk -y
```

## Submodules

- **Commerce Generate** (`commerce_generate`) — integrates with **Devel Generate**
  to fabricate dummy commerce products with variations for testing. Enable it only
  when you need test data (it requires the Devel module):

  ```bash
  drush en commerce_generate -y
  ```

## Verify it worked

Open any product that has a multi‑attribute variation type and go to its
**Variations** tab (`/product/{id}/variations`). You should see the bulk actions
(Create, Duplicate, Set price, and so on) and a "created / not used / maximum"
count. There is no settings form to configure — SKU behaviour is set on the
variation type's **Manage form display** as described in the
[overview](../index.md).
