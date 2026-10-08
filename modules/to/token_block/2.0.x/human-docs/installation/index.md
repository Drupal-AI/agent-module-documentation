# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`token`) — this is
  the only dependency, and Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/token_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_block -y
```

Drupal enables the Token module as a dependency. There is no configuration form —
place and configure a Token Block through **Structure → Block layout**, as
described on the [overview page](../index.md#how-to-use-it).
