# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2 || ^12`).
- Core modules **Content Moderation**, **Node**, **Views**, and **Layout Builder** — all
  enabled automatically as dependencies.
- You will want at least one content type set up under a Content Moderation workflow, or there
  is nothing for the dashboard to show.
- Recommended: the **Chart.js** library (`nnnick/chartjs`) installed locally, for the activity
  chart (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required core modules'
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/moderation_dashboard -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

### Chart.js library (recommended)

For the activity graph, install the Chart.js library locally so it isn't loaded from a CDN:

```bash
composer require nnnick/chartjs
```

Place it where Drupal can find it (e.g. `libraries/chart.js/` or `libraries/chartjs/`); the
module auto‑detects the local copy. If you can't install it locally you can switch to the CDN
option on the settings form instead (see [Configuration](../configuration/index.md)). The
status report at **Reports → Status report** warns if the CDN option is off and no local
Chart.js is found.

## Enable the module

```bash
drush en moderation_dashboard -y
```

This enables Content Moderation, Node, Views, and Layout Builder as dependencies if they
aren't already on, and installs the four dashboard Views and the layout. There are no
submodules.

## After enabling

Grant the dashboard permissions to your editorial roles and, optionally, adjust the settings
and customize the layout — see [Configuration](../configuration/index.md). Then visit
`/user/{uid}/moderation-dashboard` as an editor to see it.
