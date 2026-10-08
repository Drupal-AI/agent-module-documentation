# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- Core's **Configuration** (`config`) and **File** (`file`) modules — both part of
  Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_guardian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_guardian -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_guardian -y
```

## Assign permissions carefully

Config Guardian ships a broad, fine-grained permission set — administer, and
create / restore / view / delete / export / import snapshots, plus impact analysis
and synchronize/import/export configuration. At **People → Permissions**
(`/admin/people/permissions`):

- Grant read-only permissions (view snapshots, impact analysis) more freely.
- Grant **restore, import, synchronize, and administer** only to trusted
  operators, because those actions overwrite the site's live configuration.

## Verify it worked

Open the Config Guardian dashboard from the admin menu and take an initial
snapshot (or run `drush cg-snap`). Confirm the snapshot is listed, which verifies
the module can read the active config and write to the file storage.
