# Installation

## Requirements

This module coordinates several other tools, so it has real dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- **Acquia Site Studio / Cohesion** — the `acquia/cohesion` library
  (`^7.4.0 || ^8.0.0`) and the `cohesion_sync` module.
- **Config Ignore** (`drupal/config_ignore` `^3.0`).
- **Config Split** (`drupal/config_split` `^2.0`).

These are pulled in for you when you require the module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sitestudio_config_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Cohesion, Config
Ignore, and Config Split and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/sitestudio_config_management -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitestudio_config_management -y
```

On enable, the module writes its recommended configuration: it appends
`cohesion_*` to Config Ignore's ignored entities, installs a Config Split named
`site_studio` that isolates `cohesion_*` config into a `sitestudio` folder, and
enables all `cohesion_*` entity types for Site Studio sync. It also records the
current Cohesion version in Drupal's state.

After enabling, make sure Site Studio itself is configured with its API key and
organization key; the module's Site Studio steps stay dormant until then. See the
"How to use it" section of the [overview](../index.md).

There are no submodules.
