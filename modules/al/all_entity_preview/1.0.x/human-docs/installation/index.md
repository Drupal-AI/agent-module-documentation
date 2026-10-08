# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No third-party Composer or PHP libraries, and no other contrib modules are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/all_entity_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/all_entity_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The Composer package is `drupal/all_entity_preview`, but the module's **machine
name is `preview`** — so that is what you enable:

```bash
drush en preview -y
```

This is a pre-release (1.0.0-alpha7), so test it before relying on it in
production. Make sure the entity types you plan to preview have the view modes
you want to preview configured.
