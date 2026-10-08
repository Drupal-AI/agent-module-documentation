# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`), version 3.x — Group Clone's 3.x releases work
  with Group 3.x, and earlier releases are no longer supported.

## Install with Composer

From the project root:

```bash
composer require drupal/group_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_clone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_clone -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Grant permissions

Group Clone provides its own permission(s). Because cloning creates group content
and can copy membership, grant the cloning permission only to trusted roles at
**People → Permissions** (`/admin/people/permissions`).

## Verify it worked

After enabling cloning for a group type (see [Configuration](../configuration/index.md)),
open any group of that type and confirm a **Clone** tab appears. Cloning the group
should produce a duplicate; the same tab then offers to revert the clone.
