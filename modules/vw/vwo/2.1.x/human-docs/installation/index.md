# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party libraries.
- An active **VWO / Wingify account** and account ID — without one, the snippet
  has nothing to load.

## Install with Composer

From the project root:

```bash
composer require drupal/vwo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/vwo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vwo -y
```

## Grant the permission

All of VWO's admin forms are gated by the **Administer VWO** (`administer vwo`)
permission. Grant it to trusted administrators only:

```bash
drush role:perm:add administrator 'administer vwo'
```

Next, add your account ID and visibility rules — see
[Configuration](../configuration/index.md).
