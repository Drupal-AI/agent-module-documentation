# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or higher** (required for Drupal 10 and 11).
- A valid **CONNECTsms subscription** — the module is the front end for that
  service and cannot send messages without an account and its activation key.

There are no other Drupal module dependencies and no third‑party Composer
libraries of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leadsms_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leadsms_text -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leadsms_text -y
```

## Verify it worked

After enabling, go to **`/admin/config/leadsms_text/settings`** and confirm the
settings form loads. Once you have entered your CONNECTsms activation key (see
[Configuration](../configuration/index.md)), the LEADsms widget should appear on
your site and accept a test message. Send one and confirm it reaches your
CONNECTsms account.
