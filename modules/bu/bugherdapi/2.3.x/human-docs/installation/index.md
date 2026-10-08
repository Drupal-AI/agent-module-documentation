# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`) — current Drupal
  only.
- No other module dependencies and no third-party Composer or PHP libraries.
- A **BugHerd account** with a project, so you have the project's key to connect
  the overlay to.

## Install with Composer

From the project root:

```bash
composer require drupal/bugherdapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bugherdapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bugherdapi -y
```

## Next step

Decide who sees the overlay before you turn it on for real visitors — see
[Configuration](../configuration/index.md).
