# Installation

## Requirements

Drutopia Group is a configuration feature, but it pulls in several contributed
projects. You need:

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- The **Group** module (`group`, and its `gnode` submodule) — the foundation the
  group type is built on.
- The **Address** module (`address`) — for the group's postal-address field.
- **Config Perms** (`config_perms`), **CTools** (`ctools`), **Paragraphs**
  (`paragraphs`), **Display Suite** (`ds`) and **Pathauto** (`pathauto`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`) — the Drutopia base feature.

There are no additional PHP-library or third-party Composer requirements beyond
these Drupal projects, and Composer will fetch them for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group, Address
and the other required projects alongside the feature.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_group -y
```

Enabling the module imports the group type, fields, roles, vocabulary, Views and
Pathauto patterns, and enables its dependencies. Its install hook then runs
`node_access_rebuild()` so node access grants reflect group membership — on a
large site this rebuild can take a little time.

## Verify it worked

Log in as an administrator and visit **Groups** (`/admin/group`). You should be
able to add a group (`/group/add`) with address, contact and image fields and a
group-type selector. Check **Structure → Group types** (`/admin/group/types`) to
confirm the `group` type and its member/outsider/anonymous roles are present.
