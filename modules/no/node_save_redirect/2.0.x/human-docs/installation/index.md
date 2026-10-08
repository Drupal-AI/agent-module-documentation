# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

The module works with core's Node module and has no other module dependencies,
no third-party Composer requirements, and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_save_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_save_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_save_redirect -y
```

The module ships no submodules and adds no configuration page. To use it, edit a
content type and set the redirect behaviour in its **Submission** section — see
the [overview](../index.md#how-to-use-it) for the step-by-step.
