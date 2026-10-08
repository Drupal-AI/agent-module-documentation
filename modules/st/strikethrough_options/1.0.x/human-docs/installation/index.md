# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** and **Options** modules (part of a standard install) — the
  widget applies to options-style fields such as List fields.
- No third-party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/strikethrough_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/strikethrough_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en strikethrough_options -y
```

## Verify it worked

Create or open a **List** field on a content type, go to that content type's
**Manage form display**, and open the widget dropdown for the field. The option
**Check boxes/radio buttons - Strikethrough** should be available. Select it, choose
a color in its settings, save, and check the entity's edit form — the options should
appear with the strikethrough style. There is no separate settings page; all
configuration is done here on Manage form display, as described in the
[main guide](../index.md).
