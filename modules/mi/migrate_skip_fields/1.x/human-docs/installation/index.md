# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module. You'll also be using the standard
  Drupal‑to‑Drupal upgrade migrations this module filters.

There are no third‑party Composer or PHP library requirements.

> **Version note:** this release line is `1.x` (currently an alpha). As with any
> pre‑stable module, test the migration on a copy before running it against real
> data.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_skip_fields -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_skip_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_skip_fields -y
```

## Configure the skips

The module does nothing until you tell it which fields to skip, and that happens
in `settings.php` rather than in the admin UI. See
[How to configure the skips](../index.md#how-to-configure-the-skips) in the
overview for the exact settings.

## Verify it worked

Set up a small skip list in `settings.php`, then run your upgrade migration
against a test copy of the source site and confirm the excluded fields do not
appear on the migrated content. Adjust the list until the result matches what you
want before running the real migration.
