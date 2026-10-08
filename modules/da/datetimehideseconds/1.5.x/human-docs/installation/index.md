# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — the only dependency, and
  Drupal enables it automatically.
- No third-party Composer libraries or PHP extensions.

If you want the toggle to appear on range fields too, you will also need core's
**Datetime Range** module (`datetime_range`) enabled — the checkbox then shows up
on its widgets as well.

## Install with Composer

From the project root:

```bash
composer require drupal/datetimehideseconds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/datetimehideseconds -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetimehideseconds -y
```

Enabling the module adds a **Hide seconds** checkbox to the core Date/time widget
settings. It has no settings page and no permission of its own — you turn the
behavior on per field. See the [main guide](../index.md#how-to-use-it) for the
click-by-click steps.

## Verify it worked

Go to a bundle's **Manage form display** page that has a Date/time field — for
example `/admin/structure/types/manage/article/form-display`. Click the gear icon
on the datetime field's row. A **Hide seconds** checkbox should appear in the
widget settings. Tick it, save, then open that entity's edit form and confirm the
time input no longer shows seconds.
