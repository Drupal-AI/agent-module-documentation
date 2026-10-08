# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Field** module (`field`) enabled — Drupal enables it automatically as a
  dependency.
- Shell / Drush access if you want to use the module's Drush commands.
- No third-party Composer packages, PHP extensions, or external libraries are listed
  as required.

## Install with Composer

From the project root:

```bash
composer require drupal/synlang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synlang -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synlang -y
```

## Verify it worked

Run `drush list` and confirm Synlang's commands are registered. Because the module
is lightly documented, review what it exposes in your own environment before
depending on it in production.
