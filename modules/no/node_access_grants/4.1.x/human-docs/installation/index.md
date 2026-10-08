# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 7.1 or newer** (`php: >=7.1`).
- No other module dependencies, and no third-party PHP libraries. It uses core's
  node access system.

## Install with Composer

From the project root:

```bash
composer require drupal/node_access_grants -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_access_grants -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_access_grants -y
```

Enabling it **by itself changes nothing** — it only takes effect once one of your
custom modules depends on it and provides a service tagged `node_access_grants`
(see the "How to use it" section of the [overview](../index.md)).

## Verify it worked

There's no UI to check. Confirm the module appears as enabled on the **Extend**
page (`/admin/modules`) or via `drush pm:list --status=enabled | grep
node_access_grants`. From there, the real verification is in your own module's
grants tests and a **node access rebuild** after wiring up your service.
