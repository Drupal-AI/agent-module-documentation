# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) enabled — this is the only dependency, and it is
  part of the standard Drupal install, so it is almost certainly already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_view_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_view_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_view_permissions -y
```

Enabling the module does two things automatically: it flags Drupal to rebuild its
node access grants, and — to preserve the site's existing behavior — it grants **View
any content** for every existing content type to the anonymous and authenticated
roles. Published content therefore stays visible to everyone until you deliberately
restrict it on **People → Permissions**. See
[How to use it](../index.md#how-to-use-it) for the next steps.

There are no submodules.
