# Installation

## Requirements

Migrate: Skip File On Not Exists needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — a declared dependency, enabled
  automatically. For upgrades you will typically also have Migrate Drupal and/or the
  Migrate Upgrade / Migrate Plus contrib tooling in place, but those are your
  migration's concern, not a requirement of this module.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_skip_on_404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_skip_on_404 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_skip_on_404 -y
```

That is the entire setup for the automatic behavior — with the module enabled, the
standard Drupal‑7 file migrations will skip missing files. There is no settings page
and no permissions to grant.

A common pattern is to enable it right before an upgrade run and disable it
afterward; because the module stores no configuration, there is nothing to clean up
when you remove it.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Run (or re‑run) a migration that copies files while some source files are missing —
for example a Drupal‑7 file migration. Instead of the run failing on the first
missing file, the affected rows are skipped and messages are recorded in the
migration's message table. See the [overview](../index.md#how-to-use-it) for using the
`skip_on_404` plugin in a custom migration.
