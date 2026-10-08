# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other module dependencies and no third-party Composer or PHP libraries.
- A **BugHerd account** with a project, so you have the project's key to connect
  the overlay to.

## Install with Composer

From the project root:

```bash
composer require drupal/bugherd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bugherd -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bugherd -y
```

## Next step

Before the overlay is useful you need to connect your BugHerd project and decide
who sees it — see [Configuration](../configuration/index.md). A safe default is
to grant `access bugherd` to reviewer roles only, and to run the module on a
staging environment rather than production.
