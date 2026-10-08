# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** — this module is a set of Drush commands, so Drush must be installed
  (it almost always is on a modern Drupal project). If you don't already have
  Drush and Drupal core, you probably don't need this module.

There are no other module dependencies, no PHP library requirements, and nothing
to configure.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_lock -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_lock -y
```

## Verify it worked

Ask Drush for the command help — if the module is enabled, the lock commands are
available:

```bash
drush help lock:wait
drush help lock:release
```

You can also try a quick round-trip: `drush lock:wait test_lock --delay=5`
should acquire the lock immediately, and `drush lock:release test_lock` should
free it again.
