# Installation

## Requirements

Better Formats is lightweight and has no third-party libraries:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Filter** module, which powers text formats — it is part of a standard
  Drupal install and is enabled automatically as a dependency.

There are no Composer or PHP library requirements beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/better_formats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_formats -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_formats -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

Enabling the module does not change any field on its own — it only *adds* the
**Text Formats** fieldset to text field configuration forms and introduces the one
global setting and the new permissions. To actually restrict a field, open that
field's settings and configure it as described in
[Configuration](../configuration/index.md).
