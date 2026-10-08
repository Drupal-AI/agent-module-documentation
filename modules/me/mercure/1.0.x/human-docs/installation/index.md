# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other Drupal modules are required.
- **A Mercure hub.** The module connects Drupal to a Mercure hub but does not
  provide one — you need a running hub (self‑hosted or managed) that Drupal can
  reach. Run it over **HTTPS/WSS** in production.

The Mercure PHP component the module builds on is pulled in through Composer, so
install with Composer rather than downloading a tarball.

## Install with Composer

From the project root:

```bash
composer require drupal/mercure -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Mercure PHP component.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercure -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercure -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`) or with
`drush pm:list --status=enabled | grep mercure`. The module does no useful work
until you give it your hub URL and JWT secret — head to
[Configuration](../configuration/index.md) next.
