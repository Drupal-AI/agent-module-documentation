# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables as a dependency.
- One or more **Entity Reference** fields for the buttons to attach to (the module
  targets configured entity-reference fields, not base fields).

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/entityconnect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entityconnect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityconnect -y
```

At install time, Entity Connect grants the *administer entityconnect* permission
to every role that already has *access administration pages*. Review the
permissions and the global defaults next — see
[Configuration](../configuration/index.md).
