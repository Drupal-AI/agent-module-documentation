# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Shortcut** module (`shortcut`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Shortcut
  Menu.

There are no third-party Composer or PHP library requirements.

> **Beta release.** The tracked version is `3.0.0-beta8`. It is usable, but the
> parent-field storage may still change between beta releases — take the usual
> care before running it on a production site, and back up first.

## Install with Composer

From the project root:

```bash
composer require drupal/shortcut_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/shortcut_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortcut_menu -y
```

Enabling the module adds a parent field to the shortcut entity, so a schema
update is applied at install time. After that, open any shortcut set's
customise screen and you'll find the new draggable tree. See
[How to use it](../index.md#how-to-use-it) in the overview.

> **Before uninstalling:** because the parent field lives on the shortcut
> entity, its data is not automatically removed when you uninstall the module.
> Check your `shortcut` field storage before removing the module from a
> production site.
