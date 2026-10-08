# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: >=10`).
- Core's **Migrate** module (`migrate`) — the only dependency; it provides the
  Migrate API this module extends. Drupal enables it automatically.
- **Drush** if you want to use the batch commands (the service can also be called
  from your own PHP).

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_batch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_batch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_batch -y
```

## Verify it worked

Run `drush migrate:batch-offset my_migration` (using a real migration id) — it
should report the current offset (0 before any batches have run). From there,
`drush migrate:batch-next my_migration` processes the first batch. See
[the module overview](../index.md#how-to-use-it) for the full command list and the
service API.
