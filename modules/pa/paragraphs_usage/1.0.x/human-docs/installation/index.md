# Installation

## Requirements

Paragraphs Usage extends the Paragraphs module:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Paragraphs** module (`drupal/paragraphs` `^1.12`) — a hard
  dependency that Composer installs for you.

There are no other third‑party Composer or PHP library requirements. **Admin Toolbar
Extra Tools** (`admin_toolbar_tools`) is optional — if it is enabled, Paragraphs
Usage adds a Usage link under each paragraph type in the admin toolbar.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_usage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_usage -y
```

Drupal enables the base **Paragraphs** module as a dependency automatically. There
are no submodules and nothing to configure — enabling the module immediately adds
the **Usage** report to every paragraph type.

## Verify it worked

Go to **Structure → Paragraphs types**, open any paragraph type, and look for the
**Usage** tab. Opening it should show a table of the bundles and fields that
reference that type (or a "not used" message). Access requires the **Administer
paragraph types** permission. See the [overview](../index.md) for how to read the
report.
