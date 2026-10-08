# Installation

## Requirements

Config Role Split needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Config Filter** module (`drupal/config_filter`) — this provides the filter
  API the module plugs into, and Composer pulls it in for you.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_role_split -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **Config Filter**
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_role_split -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_role_split -y
```

This enables the module along with **Config Filter** if it isn't already on.

## Grant the permission (optional)

Only users with the restricted **Administer config role split** permission can
reach the admin screen and create Role Split entities. Grant it sparingly at
**People → Permissions** (`/admin/people/permissions`).

Once enabled, nothing changes on the running site — the module only acts during
config export/import. Head to [Configuration](../configuration/index.md) to define
your first Role Split.
