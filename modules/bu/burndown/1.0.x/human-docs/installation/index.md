# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core modules **Datetime**, **Field**, **Image**, **Link**, **Options**, and
  **Taxonomy**. Drupal enables these automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/burndown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/burndown -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en burndown -y
```

## Optional submodule — Time Tracker

Burndown ships a `burndown_time_tracker` submodule for logging time against work.
Enable it only if you need time tracking:

```bash
drush en burndown_time_tracker -y
```

It requires the base Burndown module, which is already present once you have
installed it above.

After enabling, grant Burndown's permissions to the right roles under **People →
Permissions** so that project data — including who logged what time — is visible
only to the appropriate team.
