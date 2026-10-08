# Installation

## Requirements

REST menu items needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) — a declared dependency, enabled
  automatically when you turn on this module.

There are no third‑party Composer libraries or special PHP extensions to install.
The **REST UI** module (`drupal/restui`) is not required, but it makes enabling the
resource much easier and is recommended.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_menu_items -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_menu_items -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

If you want the friendlier resource‑enabling UI, also install REST UI:

```bash
composer require drupal/restui -W
```

## Enable the module

```bash
drush en rest_menu_items -y
```

Drupal enables core's `rest` module at the same time as a dependency.

> **Do not stop here.** Enabling the module alone does not make the endpoint respond.
> You still have to enable the REST resource and grant the
> `restful get rest_menu_item` permission — see the
> [overview](../index.md#how-to-use-it) for those steps.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Once you have enabled the resource and granted the permission, request a menu such as
`/api/menu_items/main?_format=json`. You should receive the menu's links as nested
JSON. A 406 means you forgot `_format`; a 403 means the resource is not enabled, the
permission is missing, or the menu is excluded by the allowed‑menus setting.
