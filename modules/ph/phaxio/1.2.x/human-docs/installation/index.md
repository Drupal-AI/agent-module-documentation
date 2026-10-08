# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies — Phaxio depends on Drupal core only.
- A **Phaxio account** with API credentials (an API key and API secret).

There are no extra Composer libraries to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/phaxio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phaxio -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phaxio -y
```

## Verify it worked

Log in as an administrator and confirm the module is enabled at **Extend**
(`/admin/modules`). Then head to [Configuration](../configuration/index.md) to enter
your Phaxio API credentials before you try to send a fax.
