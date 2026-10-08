# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies — the module uses only Drupal core. It works alongside core's
  own **User** module and the standard **Administer users** permission.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_password_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/restrict_password_change -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_password_change -y
```

There is no configuration step and no settings form. Enabling the module simply
makes its new permissions available on **People → Permissions** — none of them
are granted to any role by default, so nothing changes until you assign them (see
[Configuration](../configuration/index.md)).

## Submodules

Restrict Password Change ships no submodules.
