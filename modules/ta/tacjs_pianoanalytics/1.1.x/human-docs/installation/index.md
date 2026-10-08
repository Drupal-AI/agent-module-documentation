# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Piano Analytics** module (`pianoanalytics`) — provides the actual tracking.
- The **TacJS** module (`tacjs`) — the tarteaucitron.js consent manager that gates
  the tracking behind consent.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tacjs_pianoanalytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Piano Analytics
and TacJS dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tacjs_pianoanalytics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tacjs_pianoanalytics -y
```

This also enables the Piano Analytics and TacJS dependencies if they are not
already on.

## Verify it worked

With Piano Analytics configured and a TacJS consent banner in place, confirm that
Piano Analytics now appears as a consent-managed service in TacJS and that its
tracking only fires after a visitor accepts consent.
