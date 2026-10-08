# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — Drupal enables it
  automatically as a dependency. (For the range widget you'll also want core's
  Datetime Range module, which provides the `daterange` field type.)
- **Optional:** the contrib **Duration Field** module
  (`drupal/duration_field`, 8.x-2.0-rc3 or newer) — required only if you want the
  **Date and time range with duration** widget. Without it, that one widget is
  simply hidden; everything else works.

There are no additional third-party Composer packages or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

If you want the duration range widget, also require Duration Field:

```bash
composer require drupal/duration_field -W
drush en duration_field -y
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/datetime_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_extras -y
```

There is no settings form. Add a **Time only** field on a content type's **Manage
fields** tab, or switch a core date field to one of the new widgets on **Manage
form display** — see [How to use it](../index.md#how-to-use-it).

This module ships no submodules.
