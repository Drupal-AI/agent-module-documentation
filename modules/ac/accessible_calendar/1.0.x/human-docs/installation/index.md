# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views** module (`views`) — the calendar sources its content from a View.
  Views ships with Drupal core and is enabled on standard installs; Drupal will
  enable it automatically as a dependency if it is off.

## Install with Composer

From the project root:

```bash
composer require drupal/accessible_calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/accessible_calendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessible_calendar -y
```

Once enabled, the accessible calendar display becomes available to use inside
Views — see [How to use it](../index.md#how-to-use-it).
