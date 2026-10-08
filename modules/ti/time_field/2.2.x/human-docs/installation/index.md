# Installation

## Requirements

Time Field is lightweight and needs only core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — the only dependency, and
  Drupal enables it automatically when you turn on Time Field.
- To add and manage fields through the UI you'll want core's **Field UI** module
  enabled as well.

The **Token** and **Feeds** integrations are optional — install those modules
only if you want them. There are no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/time_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/time_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_field -y
```

Or enable **Time Field** from **Extend** (`/admin/modules`).

## Upgrading from an older release

If you are upgrading a site that already stored `time_range` data, run database
updates afterward so open‑ended ranges migrate correctly:

```bash
drush updatedb -y
```

## Next steps

There is nothing to configure globally. Add a **Time** or **Time Range** field to
any content type and set its widget and formatter — see
[How to use it](../index.md#how-to-use-it) on the overview page.
