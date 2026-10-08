# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Microsoft Clarity account and project ID** — sign up at
  [clarity.microsoft.com](https://clarity.microsoft.com/), register your site,
  and copy the project ID. You enter it during configuration.

There are no module dependencies and no third-party library requirements — the
only external dependency is the Clarity service itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ms_clarity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ms_clarity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ms_clarity -y
```

The module ships no submodules. Nothing is tracked until you enter a project ID
— head to [Configuration](../configuration/index.md) next.
