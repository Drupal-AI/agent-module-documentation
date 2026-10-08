# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The base `brightcove_extras` module has **no hard runtime dependency** — but each
  submodule declares its own:
  - `brightcove_extras_player` and `brightcove_extras_sync` build on the
    contributed **Brightcove** module, so install and configure that first.
  - `brightcove_extras_admin` additionally depends on **Views** (core) and the
    contributed **Entity Usage** module for its broken‑reference report.
  - `brightcove_extras_ga4` pushes events to your site's dataLayer (pair it with
    your existing GA4 setup).

## Install with Composer

From the project root:

```bash
composer require drupal/brightcove_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in shared
dependencies as needed. If you plan to use the admin submodule, also require the
Entity Usage module (`composer require drupal/entity_usage -W`) and the Brightcove
module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brightcove_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module plus only the submodules you actually want:

```bash
# Base helper (usually enabled automatically as a submodule dependency)
drush en brightcove_extras -y

# Pick the pieces you need:
drush en brightcove_extras_player -y   # in-page video.js player
drush en brightcove_extras_ga4 -y      # GA4 engagement events
drush en brightcove_extras_admin -y    # video overview + broken-reference report
drush en brightcove_extras_sync -y     # incremental sync + Drush commands
```

## Submodules

This project is deliberately split into the four submodules listed above. Enable
each one individually — there is no requirement to turn them all on, and the base
module on its own only provides the shared embed‑URL helper for the others.
