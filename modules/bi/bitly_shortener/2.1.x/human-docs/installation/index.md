# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Bitly account** and an **access token** to authenticate API calls (see
  [Configuration](../configuration/index.md)).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bitly_shortener -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bitly_shortener -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bitly_shortener -y
```

The module cannot shorten anything until you enter a Bitly access token — continue
to [Configuration](../configuration/index.md).
