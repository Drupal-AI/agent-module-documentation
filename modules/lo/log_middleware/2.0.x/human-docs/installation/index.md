# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third-party Composer or PHP library requirements. This is a developer
framework — on its own it adds middleware *support*, not any middleware.

## Install with Composer

From the project root:

```bash
composer require drupal/log_middleware -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log_middleware -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_middleware -y
```

Enabling the module swaps in its logger-channel implementation. Until a module
provides a `log_middleware`-tagged service, the logger behaves exactly like core's.

## Verify it worked

Because there's no UI, the practical check is in code: define a
`log_middleware`-tagged service (or enable the bundled
`tests/modules/log_test_middleware` example), then confirm that log messages are
processed through your middleware — for example that it can alter or discard a
message. See the [overview page](../index.md) for how to register middleware.
