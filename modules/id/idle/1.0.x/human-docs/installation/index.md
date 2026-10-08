# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Service** module (`service`) — an additional dependency this module
  relies on. Install it alongside Idle if it isn't already present.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/idle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the Service module dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/idle -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en idle -y
```

Drupal enables the required Service module automatically as a dependency.

## Verify it worked

Turn on maintenance mode using Idle's one‑click toggle (or at **Configuration →
Development → Maintenance mode**), then visit the site as an anonymous user — you
should see the retro television‑style maintenance page with your configured
message in the center. Turn maintenance back off when you're done.
