# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) — enabled automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_delete -y
```

There are no submodules.

## Grant the permission

The delete form is gated by the module's own **Delete configuration**
permission, which is marked as restricted-access. Assign it only to a trusted
administrator role at **People → Permissions** (`/admin/people/permissions`), or
with Drush:

```bash
drush role:perm:add administrator 'delete configuration'
```

## Verify it worked

Visit **Configuration → Development → Configuration synchronization** and confirm
a **Delete** tab appears (`/admin/config/development/configuration/delete`). See
the [main guide](../index.md#how-to-use-it) for how to use it safely.
