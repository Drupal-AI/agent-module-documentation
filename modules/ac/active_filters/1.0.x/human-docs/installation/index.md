# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2 or newer** (`php: ^8.2`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it's
  on by default in a standard install. Drupal enables it automatically as a
  dependency if needed.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/active_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/active_filters -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en active_filters -y
```

## Next steps

Enabling the module makes the **Global: Active Filters** area available in the Views
UI. Add it to a View that has exposed filters to switch it on — see
[Configuration](../configuration/index.md).
