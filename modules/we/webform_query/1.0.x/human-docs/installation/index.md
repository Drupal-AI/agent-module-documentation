# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10
  || ^11`).
- The **Webform** module (`webform`) — a required dependency, which Drupal
  enables automatically (install it with Composer first if it is not already
  present).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_query -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform (and
update any shared dependencies) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_query -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_query -y
```

The module ships no submodules and has no configuration page or admin UI. Once
enabled, the `webform_query` service is available to call from custom code — see
the [overview](../index.md#how-to-use-it) for usage examples.
