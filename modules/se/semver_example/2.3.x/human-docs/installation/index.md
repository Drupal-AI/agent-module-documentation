# Installation

> **Not for production.** This module is a demonstration/testing artifact only and
> its maintainers mark it *Unsupported*. Install it only if you are experimenting
> with Drupal.org release/version behavior.

## Requirements

- **Drupal 8 or later** (`core_version_requirement: >=8`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/semver_example -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/semver_example -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en semver_example -y
```

The module enables instantly and does nothing else. There is no configuration and
nothing to verify beyond seeing it listed as enabled.
