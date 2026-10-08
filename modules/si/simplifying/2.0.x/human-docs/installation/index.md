# Installation

## Requirements

Simplifying needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **JS Cookie** module (`drupal/js_cookie`, `^1.0 || ^2.0`) — a small library
  wrapper used for the "full administration" cookie toggle. Composer pulls it in
  automatically as a dependency.

There are no PHP‑library requirements beyond the above.

## Install with Composer

From the project root:

```bash
composer require drupal/simplifying -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (including JS Cookie) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simplifying -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplifying -y
```

Enabling Simplifying also enables its JS Cookie dependency.

## Grant the permissions

Simplifying defines three permissions, all marked as *restricted* (grant them only
to trusted roles):

| Permission | What it allows |
|------------|----------------|
| **Access simplifying setting** | Reach the settings form at `/admin/config/development/simplifying` and choose what to hide. |
| **Access simplifying training page** | View the bundled static Training page at `/admin/training`. |
| **Access simplifying services page** | View the bundled static "Order additional services" page at `/admin/services`. |

At minimum, grant **Access simplifying setting** to the administrators who will
configure the simplified UI, then head to
[Configuration](../configuration/index.md).
