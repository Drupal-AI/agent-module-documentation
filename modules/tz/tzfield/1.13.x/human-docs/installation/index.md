# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module, which is part of every standard Drupal install.

There are no other module dependencies and no third-party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tzfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tzfield -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tzfield -y
```

Once enabled, a new **Time zone** field type is available when you add a field
to any entity type. There is no admin settings page — see the main guide for how
to add and configure the field.
