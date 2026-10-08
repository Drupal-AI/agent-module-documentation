# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drush**, since the module works by extending Drush's `sql:sanitize` command.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_sanitize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Since this is a development-time tool, you may prefer to
install it as a dev dependency (`composer require --dev drupal/advanced_sanitize`)
so it is not deployed to production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_sanitize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_sanitize -y
```

Enable it on the environment where you run the sanitize — usually as part of the
process that copies and scrubs a production database for dev or staging. Once
enabled, its plugins hook into `drush sql:sanitize` automatically. See the
[overview](../index.md#how-to-use-it) for how to run the sanitize and why
reviewing field coverage matters.
