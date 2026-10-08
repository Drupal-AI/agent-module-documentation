# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.

There are no dependencies beyond Drupal core (it works with the core **User** and **Field
UI** modules, both part of a standard install) and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/account_field_split -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/account_field_split -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en account_field_split -y
```

There are no submodules. On install the module sets its own weight (to 101) so its form
adjustments run after other modules — nothing you need to do by hand.

## After enabling

The bundled "User name and password" element on the user **Manage form display** is now split
into seven separate, rearrangeable fields. Head to
**Configuration → People → Account settings → Manage form display**
(`/admin/config/people/accounts/form-display`) to arrange them — see
[How to use it](../index.md#how-to-use-it).

To undo everything and go back to core's bundled behavior, uninstall the module
(`drush pmu account_field_split -y`).
