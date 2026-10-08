# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other modules or third‑party libraries are required by this base module
  itself. On its own it only stores shared settings — the modules that consume
  those settings (the CanvasApi integration modules) are what you install
  alongside it to actually connect to the Canvas LMS.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_lms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_lms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_lms -y
```

Enable this base module, then install and enable the CanvasApi integration
module(s) you need. Store any Canvas API token as a secret in an environment
variable and reference it through a Key entity in the consuming module — never in
committed configuration.
