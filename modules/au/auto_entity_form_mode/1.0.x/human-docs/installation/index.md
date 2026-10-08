# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

The module has no other module dependencies and no third-party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_entity_form_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_entity_form_mode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_entity_form_mode -y
```

There is no configuration. Once enabled, the site's entity form modes are
registered automatically for use in custom code.
