# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Link** module (`link`) — this is the only module dependency, and Drupal
  enables it automatically when you turn on Link with description.

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/link_description -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_description -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_description -y
```

Once enabled, **Link with description** appears as a field type when you add a
field on any bundle's *Manage fields* page — see [the index page](../index.md) for
how to add and display it. There is no configuration form.

There are no submodules.
