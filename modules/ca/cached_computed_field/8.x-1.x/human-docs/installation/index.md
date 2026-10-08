# Installation

## Requirements

- **Drupal 8.9, 9.1, 10, or 11** (`core_version_requirement: ^8.9 || ^9.1 || ^10 || ^11`).
- A working **cron** — cron drives the background refresh of stale field values.
- Some **custom code**: the module stores values but does not compute them, so you
  will write an event subscriber to recompute the fields you own (see the
  [`agent/`](../agent/start.md) docs).
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cached_computed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cached_computed_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cached_computed_field -y
```

After enabling, add a cached-computed field to an entity via **Manage fields**, then
write the event subscriber that recomputes its value — see the module's
[`agent/extend/subscriber.md`](../agent/extend/subscriber.md) for the pattern.
Refresh behaviour can be tuned on the settings form at
`/admin/config/cached_computed_field/settings`.
