# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Field** (`field`) and **Options** (`options`) modules — Drupal enables
  both automatically as dependencies. (The image‑style field is built on top of the
  Options list field, and you will use it alongside core's Image field.)

There are no third‑party Composer or PHP library requirements, no settings page,
and no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/field_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_image_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_image_style -y
```

There are no submodules. Once enabled, the new *Image style* field type and the
*Field Image Style formatter* become available when you build your fields and
displays — see [How to use it](../index.md#how-to-use-it).
