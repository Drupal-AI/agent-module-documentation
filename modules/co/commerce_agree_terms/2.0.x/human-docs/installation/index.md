# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **[Drupal Commerce](https://www.drupal.org/project/commerce)** version
  **2.8 or newer, or 3.x** (`drupal/commerce: ~2.8 || ^3`), with its
  **Checkout** submodule (`commerce_checkout`) enabled — this is what supplies the
  checkout flows the pane plugs into.
- No third-party Composer or PHP library requirements.

You will also want an existing **Terms and Conditions** (or privacy policy) node
on the site for the checkbox to link to. If you don't have one yet, create a Basic
page with your terms text before configuring the pane.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_agree_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce and shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_agree_terms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_agree_terms -y
```

Drupal enables the required `commerce_checkout` module automatically if it is not
already on. There are no submodules.

## Next steps

There is no settings page to visit. Head to
[Configuration](../configuration/index.md) to add the terms checkbox to your
checkout flow and set its wording.
