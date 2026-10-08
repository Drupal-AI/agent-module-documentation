# Installation

## Requirements

Language Field is lightweight and has no third‑party library requirements. It
needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **Field** (`field`), **Language** (`language`), and **Options**
  (`options`) modules — Drupal enables these automatically as dependencies when
  you turn on Language Field.

## Install with Composer

From the project root:

```bash
composer require drupal/languagefield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/languagefield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en languagefield -y
```

There are no submodules. Once enabled, the **Language** field type becomes
available when you add a field to any bundle. See
[Configuration](../configuration/index.md) for adding and tuning a field.
