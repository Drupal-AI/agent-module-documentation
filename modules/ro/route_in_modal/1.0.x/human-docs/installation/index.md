# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements. It uses Drupal core's own
  dialog/AJAX system.

## Install with Composer

From the project root:

```bash
composer require drupal/route_in_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/route_in_modal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en route_in_modal -y
```

## Permissions

The module adds an **administer route_in_modal** permission that controls who can
open the settings form and change which routes open in a modal. Grant it only to
trusted administrators at **People → Permissions**.

## Verify it worked

Go to **Configuration → User interface → Route In Modal**
(`/admin/config/user-interface/route-in-modal`). If the settings form loads, the
module is installed. Nothing changes on your site until you list some routes —
continue to [Configuration](../configuration/index.md).
