# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`) — the module
  builds on the Access Policy API introduced in Drupal 10.3.
- Core's **User** (`user`) module, which is always present.

There are no third‑party Composer or PHP library requirements. Note that this is a
developer-oriented module — using it involves editing `settings.php` and writing a
small amount of custom code.

## Install with Composer

From the project root:

```bash
composer require drupal/external_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_roles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_roles -y
```

## Verify it worked

Enabling the module has no visible effect on its own — nothing changes until you
define external roles in `settings.php` and assign them to users. Follow
[Configuration](../configuration/index.md) to set up the mapping, then rebuild the
cache (`drush cr`) and confirm that a user carrying an external role gains the
permissions you mapped to it.
