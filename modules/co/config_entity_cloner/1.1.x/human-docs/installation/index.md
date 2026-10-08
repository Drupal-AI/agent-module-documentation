# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside Drupal core are required, and there are no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_entity_cloner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_entity_cloner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_entity_cloner -y
```

## Set the permission

The module provides its own permission controlling who may clone configuration
entities. Because cloning creates new configuration, grant it only to trusted site
builders at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Visit any configuration entity list — for example **Structure → Content types**.
Open the operations dropdown next to an item and confirm a **Clone** action now
appears.
