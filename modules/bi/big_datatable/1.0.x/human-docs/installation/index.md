# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/big_datatable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/big_datatable -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en big_datatable -y
```

After enabling, grant the module's permission under **People → Permissions** and
create a Big Data Table configuration to define how your large data set should be
displayed.
