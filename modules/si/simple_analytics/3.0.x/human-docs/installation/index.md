# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules are required, and there are no mandatory third-party Composer or
  PHP library requirements.
- **Optional:** the **Chartist** JavaScript library, used to draw the history
  charts. Download it and place it at `DRUPAL_ROOT/libraries/chartist-js` so the
  files `chartist.min.js` and `chartist.min.css` are present under
  `libraries/chartist-js`. Without it the module still works; you just won't get the
  charted history view.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_analytics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_analytics -y
```

## Optional submodule

Simple Analytics ships one optional submodule, **Simple Analytics Event**
(`simple_analytics_event`) — an example that shows how to subscribe to the tracker's
events in your own code. Enable it only if you want that example as a starting point:

```bash
drush en simple_analytics_event -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Simple Analytics Event** | `simple_analytics_event` | Example event subscriber demonstrating how to react to the tracker's events. Not needed for normal analytics use. |

## After installing

Go to **Configuration → System → Simple Analytics settings**
(`/admin/config/system/analyse`) to choose your tracking mode and enter any
third-party analytics IDs — see [Configuration](../configuration/index.md). By
default the internal tracker is already on, ignoring admin pages and authenticated
users.
