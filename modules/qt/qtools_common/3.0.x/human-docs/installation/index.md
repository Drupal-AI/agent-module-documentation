# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party libraries are required.

> **Note:** this project is not covered by Drupal's security advisory policy. It is
> a developer dependency rather than a stand-alone feature.

## Install with Composer

Usually you install Qtools Common indirectly — requiring a Qtools module that
depends on it (such as **Qtools Profiler**) brings it in automatically. To install
it directly:

```bash
composer require drupal/qtools_common -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qtools_common -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qtools_common -y
```

In most cases you will not enable it by hand — Drupal enables it automatically when
you enable a Qtools module that requires it.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep qtools_common
```

There is nothing else to check — it provides shared utilities to other Qtools
modules and has no visible output of its own.
