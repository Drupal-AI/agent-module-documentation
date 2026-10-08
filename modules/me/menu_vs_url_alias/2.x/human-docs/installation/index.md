# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [**Pathauto**](https://www.drupal.org/project/pathauto) module
  (`pathauto`) — this is a required dependency. Composer pulls it in for you with
  the command below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_vs_url_alias -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Pathauto and its own dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_vs_url_alias -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_vs_url_alias -y
```

Enabling the module does not change any content type by itself — you turn the
behaviour on per content type. See "How to use it" on the
[overview page](../index.md).

## Verify it worked

Edit a content type and confirm a **Menu vs URL Alias** vertical tab now appears on
its settings form. Enable it there, then add a node of that type: enabling a menu
item should hide the URL alias fields, and leaving the menu item off should make a
custom alias required.
