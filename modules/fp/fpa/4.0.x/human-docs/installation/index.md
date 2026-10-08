# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10.0 || ^11`).
- The **js_cookie** module (`js_cookie` `^1.0 || ^2.0`), used to remember your
  toggle and column preferences. Composer and Drupal pull it in as a dependency.

There are no other third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/fpa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `js_cookie` and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fpa -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fpa -y
```

This enables `js_cookie` alongside it. There are no submodules.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`). Instead of the
plain core table you should now see a filter box and the module/role/status
filters. Nothing else is required — the enhanced page works out of the box.

To hide any of the UI sections, see [Configuration](../configuration/index.md).
