# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

The module has no other module dependencies and no third-party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_config_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_config_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_config_form -y
```

Auto Config Form is a developer tool with no settings page of its own — once
enabled you use it to generate configuration forms for the modules you are
building. See the "How to use it" section of the [overview](../index.md).
