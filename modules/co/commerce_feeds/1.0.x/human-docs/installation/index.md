# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Feeds** module (`drupal/feeds`, `^3.0`) enabled.
- **Drupal Commerce** (`drupal/commerce`, `^2.0 || ^3.0`) with the **Commerce
  Product** submodule (`commerce_product`) enabled.
- **Optional but recommended:** the **Physical** module (`drupal/physical`). The
  physical-measurement and physical-dimensions target mappers (product weight and
  dimensions) only work if Physical is installed. If you do not import weight or
  dimensions, you do not need it.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_feeds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Feeds and Commerce if they are not already
present. If you plan to import weight or dimensions, also add the Physical module:

```bash
composer require drupal/physical -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_feeds -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_feeds -y
```

Drupal enables the dependencies (Feeds, Commerce, Commerce Product) as needed. If you
installed Physical for weight/dimensions imports, enable it too:

```bash
drush en physical -y
```

Once enabled, the module's Product processor and Commerce field targets become
available inside the Feeds feed-type builder at **Structure → Feeds**. See
[the overview](../index.md#how-to-use-it) for building your first import.
