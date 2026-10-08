# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Update** module (`update`) — Dropfort Update builds on the update data
  it collects.
- A **Dropfort account** to report the data to.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dropfort_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropfort_update -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropfort_update -y
```

Drush enables core's Update module automatically as a dependency.

## Verify it worked

1. Go to the Dropfort Update settings form under **Configuration** (route
   `dropfort_update.settings`) and confirm it loads.
2. Enter your Dropfort connection details (see
   [Configuration](../configuration/index.md)).
3. Confirm the site appears in your Dropfort dashboard and reports its update
   status.
