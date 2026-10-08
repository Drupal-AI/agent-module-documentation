# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`) enabled — this provides the list field
  types, and Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/url_friendly_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/url_friendly_options -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_friendly_options -y
```

There are no submodules and nothing to configure. The moment the module is enabled,
option-list field keys are validated on save and existing fields are checked on the
Status report — see [the overview](../index.md#how-to-use-it) for what to expect.
