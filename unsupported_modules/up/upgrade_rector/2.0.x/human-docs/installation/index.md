# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`palantirnet/drupal-rector`** library (`~0.11`) — this is the actual
  Rector toolchain and is a Composer requirement of the module, so it is pulled
  into your site's `vendor/` automatically.
- The Rector binary must be reachable from your webroot at
  `vendor/bin/rector` (or one directory up, at the project root's `vendor/`). If
  `vendor/` is not reachable, a run fails cleanly with a logged error.
- Optional: the **Upgrade Status** module, if you want Upgrade Rector's patch
  links woven into that module's readiness report.

## Install with Composer

This is a development tool that pulls in a dev‑oriented toolchain, so most teams
install it as a **development‑only dependency** and do not deploy it to
production:

```bash
composer require --dev drupal/upgrade_rector -W
```

If you prefer it as a normal requirement, drop `--dev`:

```bash
composer require drupal/upgrade_rector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`palantirnet/drupal-rector` and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/upgrade_rector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en upgrade_rector -y
```

Then visit **Reports → Upgrade Rector** (`/admin/reports/upgrade-rector`) to run
it — see [Configuration](../configuration/index.md).

## Submodules

None — Upgrade Rector ships as a single module.
