# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with products and variations — the tool manages Commerce
  products, so a working Commerce install is what makes it useful. (Commerce is
  not declared as a hard module dependency, but the tool has nothing to operate on
  without it.)
- **Layout Builder** (Drupal core) if you want to use the Layout Template Manager,
  since it clones Layout Builder configurations.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/product_manager_tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/product_manager_tool -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en product_manager_tool -y
```

## Assign permissions

The tool does nothing until you grant its permissions. At **People →
Permissions**, give a trusted store-manager role: **Access Product Manager Tool**,
**Manage Product Layouts**, **Bulk Update Product Fields**, and **Create Layout
Templates** (see the [overview page](../index.md) for what each allows).

## Verify it worked

With permissions granted, go to **`/admin/commerce/product-manager-tool`**. You
should see the tool's **Layout Manager** and **Field Manager** tabs. No further
configuration is required — the module is ready to use.
