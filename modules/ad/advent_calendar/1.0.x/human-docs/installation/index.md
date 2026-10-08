# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Views** module (`views`) enabled — it is the only dependency and is
  included with Drupal core.

There are no third-party Composer or PHP library requirements.

> **Version note:** at the time of writing this is a beta release
> (1.0.0-beta6), so test it on a non-production site before relying on it for a
> live campaign.

## Install with Composer

From the project root:

```bash
composer require drupal/advent_calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advent_calendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advent_calendar -y
```

Once enabled, the **Advent Calendar** format becomes available in any View — see
[How to use it](../index.md#how-to-use-it) on the overview page.
