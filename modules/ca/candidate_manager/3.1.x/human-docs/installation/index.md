# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 7.4 or newer**.
- Three core modules, which Drupal enables as dependencies:
  **RESTful Web Services** (`rest`), **Serialization** (`serialization`), and
  **Field UI** (`field_ui`).

## Install with Composer

From the project root:

```bash
composer require drupal/candidate_manager -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the dependencies and updates any
shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/candidate_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en candidate_manager -y
```

Drupal enables `rest`, `serialization`, and `field_ui` at the same time if they
aren't already on.

## After enabling

- Grant the candidate/company permissions to the right roles (see
  [Configuration](../configuration/index.md)).
- Review the settings page at `/admin/config/candidate-manager/settings`.
- Before going to production, read the data‑handling cautions in Configuration —
  resume files are stored publicly and the REST GET endpoint has no per‑entity
  access check.
