# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — it ships with Drupal and
  is enabled automatically as a dependency. (Core's Datetime module comes with
  it, giving you the `datetime` and `daterange` field types the formatter works
  on.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/daterange_compact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/daterange_compact -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en daterange_compact -y
```

Enabling it installs two ready-to-use formats — **Medium (date only)** and
**Medium (date & time)** — and makes the **Compact** formatter available on your
date fields. See the main guide for how to apply it and manage formats.
