# Installation

## Requirements

Domain 301 Redirect is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Path Alias** module (`path_alias`) — part of a standard Drupal install and
  enabled automatically as a dependency. (It's used so the include/exclude page list can be
  matched against aliased URLs, not just internal paths.)

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_301_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_301_redirect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_301_redirect -y
```

Enabling the module does **not** redirect anything yet — out of the box the main domain is
empty, so no redirect happens until you set one. Head to
[Configuration](../configuration/index.md) to enter your canonical domain and turn
redirection on.

There are no submodules.
