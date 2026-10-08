# Installation

## Requirements

Group permissions extends the Group module:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) — Composer requires `^2.0 || ^3.0`. This 2.0.x
  release works with both Group 2.0 and Group 3.0.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_permissions -y
```

The Group module is enabled as a dependency if it is not already on.

> **Note:** This is an alpha release (2.0.0-alpha12 at the time of writing) and it
> stores per-group data. Read `group_permissions.install` and back up before
> upgrading between alpha versions.

## Submodules

Group permissions ships no submodules.

## Verify it worked

After enabling, edit a group type (**Groups → Group types → *(your group type)***)
and confirm you can enable group-permission overriding for it, and that the
**override group permissions** permission is available to grant. Then open a group
and confirm a **Permissions** tab (`/group/{group}/permissions`) appears for it.
Follow [Configuration](../configuration/index.md) for the full setup.
