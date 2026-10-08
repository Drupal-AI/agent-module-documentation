# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no dependent modules, and no third‑party Composer or PHP library
requirements — the jQuery plugin it relies on ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/smsol -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smsol -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smsol -y
```

## Verify it worked

Go to a content type's **Manage form display** and confirm the SMSOL searchable
multi‑select widget appears as a choice for a multi‑value option field. You can
also visit **`/admin/config/system/sol-settings`** to see the module's settings
page.
