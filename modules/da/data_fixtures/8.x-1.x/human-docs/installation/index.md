# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drush** — the module is driven entirely by Drush commands, so Drush must be
  available in your environment.
- No other Drupal module, Composer, or PHP library dependencies.

> **Development only.** This module is intended for local development and CI/CD
> test environments, not production. It creates random dummy content and assumes
> the database can be truncated freely.

## Install with Composer

From the project root:

```bash
composer require drupal/data_fixtures -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_fixtures -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_fixtures -y
```

## Verify it worked

Run:

```bash
drush fixtures-load
```

If you have at least one module providing a generator tagged `data_fixtures`, the
command runs those generators and creates their sample content. On a fresh site
with no generators defined yet the command runs successfully but creates nothing —
that is expected; you supply generators from your own modules (see "How to use
it" on the [overview page](../index.md)).
