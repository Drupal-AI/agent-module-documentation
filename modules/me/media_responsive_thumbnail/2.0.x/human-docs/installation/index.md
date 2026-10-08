# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and **Responsive Image** (`responsive_image`)
  modules. Both ship with Drupal and are enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

You'll also want at least one **responsive image style** defined (core's feature,
at *Configuration → Media → Responsive image styles*), since that is what the
formatter renders with — but that's part of using the module, not installing it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_responsive_thumbnail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_responsive_thumbnail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_responsive_thumbnail -y
```

Drush enables the Media and Responsive Image modules at the same time if they
aren't already on. There is no configuration page and no permissions to grant. To
start using it, set a Media reference field's display **Format** to **Responsive
thumbnail** on the field's *Manage display* tab — see the
[main guide](../index.md#how-to-use-it).
