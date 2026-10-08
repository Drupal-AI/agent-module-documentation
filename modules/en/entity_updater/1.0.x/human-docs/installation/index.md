# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drush** to run the enqueue and queue‑run commands (or you can drive it from
  custom PHP code instead).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core. The **Queue UI** (`queue_ui`) module is an optional,
recommended companion for watching queue depth.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_updater -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_updater -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_updater -y
```

## Verify it worked

Because this module has no UI, verify it from the command line. Enqueue a small
bundle, for example:

```bash
drush entity-updater:enqueue node page
```

Then process the queue immediately:

```bash
drush queue-run entity_updater
```

The entities are re‑saved without creating new revisions. If you have the Queue UI
module enabled, you can also watch the `entity_updater` queue depth in the browser.
