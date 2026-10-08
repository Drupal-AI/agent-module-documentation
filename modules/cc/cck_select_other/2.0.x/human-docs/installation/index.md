# Installation

## Requirements

- **Drupal 11.3 or later** (`core_version_requirement: ^11.3 || ^12`). This is a
  deliberately tight requirement — the `2.0.x` branch targets Drupal 11.3+ (and
  the future Drupal 12) only. On Drupal 10, use the module's `8.x-1.x` branch
  instead.
- Core's **Options** module (`options`), which provides List fields. Drupal
  enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements. Be aware this is an
**alpha** release (`2.0.0-alpha3`) — test it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/cck_select_other -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you specifically need the alpha, Composer may require
you to permit that stability (for example a project-level `minimum-stability`
setting, or requesting the exact version).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cck_select_other -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cck_select_other -y
```

Enabling it also enables core's Options module if it isn't already on.

## Verify it worked

The module adds no admin page — you configure it per field. To confirm it's
available, edit a **List** field's **Manage form display** on any content type and
check that **Select Other** appears in the widget dropdown. See
[How to use it](../index.md#how-to-use-it) in the main guide for the field setup.
