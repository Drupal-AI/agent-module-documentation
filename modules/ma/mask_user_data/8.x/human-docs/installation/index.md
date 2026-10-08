# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The PHP **Faker** library, which generates the realistic fake values. Installing
  the module with Composer (below) pulls this in.

> **Reminder:** this module overwrites real user data. Install and run it only on
> a **non‑production** copy of your site.

## Install with Composer

From the project root:

```bash
composer require drupal/mask_user_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Faker library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mask_user_data -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mask_user_data -y
```

Enabling the module does **not** mask anything yet. There is a second, deliberate
"enable masking" safety flag you must switch on before it will run — see
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled (`drush pml | grep mask_user_data`), then head to
[Configuration](../configuration/index.md) to arm the safety flag, define your
field map, and run a masking pass against your non‑production database.
