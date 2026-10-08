# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`).
- **Symfony Messenger** (`sm`) — pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `sm` and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_metrics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_metrics -y
```

The module is ready as soon as it is installed — metric collection begins
automatically, with no configuration required. Additional options are documented
in the module's README.
