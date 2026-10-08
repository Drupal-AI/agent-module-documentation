# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jouve_project_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jouve_project_version -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jouve_project_version -y
```

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). The report should now
include your project's version/release, read from the version file in your project's
Composer root. See the "How to use it" section of the [guide index](../index.md) for
how the version file fits into your release process.
