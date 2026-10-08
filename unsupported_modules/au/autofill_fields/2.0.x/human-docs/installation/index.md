# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third‑party module, Composer, or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autofill_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autofill_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autofill_fields -y
```

The module ships no submodules. Once enabled, you set up which field fills which on
your content type's form configuration — see
[How to use it](../index.md#how-to-use-it).
