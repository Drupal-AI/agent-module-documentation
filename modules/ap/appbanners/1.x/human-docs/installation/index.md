# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).

There are no other module dependencies and no third-party Composer or PHP library
requirements. Note that this is a development (`dev`) release — test it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/appbanners -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/appbanners -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en appbanners -y
```

There are no submodules. After enabling, set your app IDs in the module's
administrator-restricted settings, then verify the banner in a supporting mobile
browser — see [How to use it](../index.md#how-to-use-it).
