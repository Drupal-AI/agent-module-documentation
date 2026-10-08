# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/sessions_expire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sessions_expire -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sessions_expire -y
```

## After enabling

There is nothing to configure — the module has no settings at this stage.
Automatic, probabilistic session garbage collection is now disabled. Make sure you
run the cleanup on a schedule instead: run it via cron, or on demand through the
module's Drush command. See the "How to use it" section of the
[main guide](../index.md).
