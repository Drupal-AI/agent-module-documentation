# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- No other modules, PHP extensions, or third-party libraries are required — the bar
  is self-contained and uses Drupal's Once API for its JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/thin_progress_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/thin_progress_bar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en thin_progress_bar -y
```

That is all that is required — the progress bar works immediately with smart
defaults. There is no mandatory configuration.

## Verify it worked

Browse the site and open a page you know is slow to load (or throttle your network
in the browser dev tools). Once a load crosses the threshold, the thin bar should
animate across the top of the page and disappear when the page finishes. On fast
pages you should see no bar at all — that is the intended behavior.
