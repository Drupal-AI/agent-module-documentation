# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) — this is the only dependency (the agreement
  text runs through a text format) and it ships with Drupal, enabled automatically
  as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/agreement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/agreement -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en agreement -y
```

## Before you target any roles

Because an active agreement redirects every request from a targeted user until
they accept, plan the permissions *before* you switch an agreement on — especially
**Bypass agreement** for deployment, monitoring, and support accounts. Continue to
[Configuration](../configuration/index.md).
