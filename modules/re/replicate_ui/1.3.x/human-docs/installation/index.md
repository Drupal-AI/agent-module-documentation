# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Replicate** module (`drupal/replicate`, `^1.0`) — the deep-clone engine
  this module puts a UI on. Composer installs it automatically.
- Core's **User** module (enabled as a dependency).

There are no PHP library or third-party Composer requirements beyond Replicate.

## Install with Composer

From the project root:

```bash
composer require drupal/replicate_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Replicate
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/replicate_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en replicate_ui -y
```

Drupal enables the Replicate module at the same time as a dependency.

## After enabling

Out of the box nothing is replicable yet — you must choose which entity types get
the Replicate UI, and grant the permission. Continue to
[Configuration](../configuration/index.md).
