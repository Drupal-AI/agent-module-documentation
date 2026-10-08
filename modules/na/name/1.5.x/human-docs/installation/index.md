# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), which is part of standard Drupal and enabled
  by default.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/name -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en name -y
```

On enable, the module registers the **Name** field type and installs a set of
default name formats (full, formal, family, given, and more), so you can add a
name field straight away — see the [main guide](../index.md#how-to-use-it-adding-a-name-field).

## Permissions

Name Field adds no permission of its own. The name-format and settings admin pages
are gated by core's **Administer site configuration** permission, so administrators
can manage formats out of the box.

## Next steps

Add a **Name** field to a content type (or the user, a term, etc.), then tune the
global separators and name formats in [Configuration](../configuration/index.md).
