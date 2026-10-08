# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and is enabled automatically as a dependency.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/hours_minutes_seconds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hours_minutes_seconds -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hours_minutes_seconds -y
```

The module ships no submodules and has no central configuration page. Once
enabled, the new field type is available when you add a field to any content
type — see [How to use it](../index.md#how-to-use-it).
