# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- Core's **System** module (`system`) — always present in a Drupal install.

There are no third-party Composer or PHP library requirements, and the module adds
no permission of its own (the settings form uses core's *Administer site
configuration*).

## Install with Composer

From the project root:

```bash
composer require drupal/requirements_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/requirements_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en requirements_manager -y
```

Nothing changes on your status report until you actually configure an override —
out of the box the module stores nothing and every requirement is shown as normal.
Head to [Configuration](../configuration/index.md) to hide a row or change a
severity.

This module has no submodules.
