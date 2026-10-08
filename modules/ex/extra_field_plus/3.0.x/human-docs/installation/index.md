# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), part of the standard install.
- The contributed **Extra Field** module (`drupal/extra_field`, version 1, 2, or
  3) — this is a hard dependency and Composer pulls it in for you.

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_field_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required Extra Field module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/extra_field_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_field_plus -y
```

Drupal enables `field` and `extra_field` as dependencies if they aren't already
on.

## Submodule — the example

The module ships one optional submodule, **`extra_field_plus_example`**, which
provides a working extra-field plugin (with settings) you can study and copy as a
starting point for your own. Enable it only if you want the example:

```bash
drush en extra_field_plus_example -y
```

Once enabled, define your own plugins in code and configure them on **Manage
display** — see [How to use it](../index.md#how-to-use-it). There is no
site-wide configuration step.
