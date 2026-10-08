# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No non‑core dependencies. It builds on core's Entity Reference / Field system,
  which is present in a standard install.

There are no third‑party Composer or PHP library requirements. (If you want the
Views filters or Entity Usage tracking it offers, have core **Views** and the
contributed **Entity Usage** module available respectively — both optional.)

## Install with Composer

From the project root:

```bash
composer require drupal/double_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This release is an alpha; if Composer does not resolve it
under your stability settings, request it explicitly (for example
`composer require 'drupal/double_reference:^2.0@alpha' -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/double_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en double_reference -y
```

## Verify it worked

Add a field to any content type and confirm that **Double Reference** appears as
an option in the "Reference" category. Being able to configure its primary and
added references (see the "How to use it" section of the [overview](../index.md))
confirms the module is active.
