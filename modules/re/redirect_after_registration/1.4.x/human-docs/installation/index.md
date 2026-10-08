# Installation

## Requirements

- **Drupal 9.5+, 10.3+, or 11** (`core_version_requirement: ^9.5 || ^10.3 || ^11`).
- No other Drupal modules, and no third-party PHP or Composer libraries — it relies
  only on core.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_after_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_after_registration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_after_registration -y
```

The module ships with the redirect set to `/user/login`. To send new users somewhere
else, see [Configuration](../configuration/index.md).
