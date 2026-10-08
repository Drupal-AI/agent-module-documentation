# Installation

## Requirements

- **Drupal 9 or later** (`core_version_requirement: >=9.0`).
- No module dependencies and no PHP libraries.
- It only *acts* on sites using the **SQLite database driver**; on other databases
  it safely does nothing, so it is fine to enable anywhere.

## Install with Composer

From the project root:

```bash
composer require drupal/sqlite_vacuum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sqlite_vacuum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sqlite_vacuum -y
```

That's all the setup there is — the module has no configuration form.

## Verify it worked

On a SQLite site, make sure Drupal cron is running; the database file is vacuumed
automatically once the interval (default 3 hours) passes. To confirm on demand, run
the module's Drush vacuum command after deleting a large amount of content and
watch the SQLite database file shrink. On a non‑SQLite site the module simply does
nothing, which is expected.
