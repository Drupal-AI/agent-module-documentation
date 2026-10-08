# Installation

## Requirements

Sync Clients needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Advanced Queue** module (`advancedqueue`) — the queue framework this
  module builds on.
- Core's **MySQL** database driver (the module's queue handling expects it).

There are no additional third-party PHP library requirements. Note that an early
version required manually adjusting the Advanced Queue table's payload column to
the JSON type; check the module's own install/README notes for the current
situation before you go live.

## Install with Composer

From the project root:

```bash
composer require drupal/sync_clients -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Advanced Queue
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sync_clients -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sync_clients -y
```

Drupal will enable Advanced Queue automatically as a dependency.

## Verify it worked

Sync Clients is a developer framework, so there is no user-facing page to check.
Confirm the module (and Advanced Queue) are enabled at **Extend**
(`/admin/modules`), then build your Sync Client and JobType plugins on top of it
as described in the [main guide](../index.md).
