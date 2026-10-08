# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- **PHP 8.1 or newer**.
- No other module dependencies and no third-party libraries.

This module is a building block: on its own it has no visible effect. You will
usually pair it with a consumer such as
[COI (Config Override Inspector)](https://www.drupal.org/project/coi), which lists
it as a dependency and installs it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/config_override_core_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (If you install COI, this module is pulled in for you, so a
separate `require` is usually unnecessary.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_override_core_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_override_core_fields -y
```

That is the entire setup — there is no configuration. Enabling it just adds the
config-key hints to core's system settings forms, ready for a consumer module like
COI to use.
