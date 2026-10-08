# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), which provides the date/datetime field
  types the widget attaches to. Drupal enables it as a dependency.
- The picker's front‑end assets are loaded from external CDNs (BootstrapCDN, cdnjs,
  momentjs, Google Fonts). Ensure those hosts are reachable, or plan to serve the
  assets locally — see the note in the [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/materialize_datetime_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/materialize_datetime_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en materialize_datetime_picker -y
```

## Verify it worked

Go to a content type's **Manage form display** for a date or datetime field. The
widget drop‑down should now offer **Materialize DateTime Picker**. Select it, save,
and open the entity's add/edit form — clicking the field should open the
Material‑styled calendar/clock. See [Configuration](../configuration/index.md) for
the per‑field and site‑wide options.
