# Installation

## Requirements

Attempt Management needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no hard dependencies outside core and no third‑party PHP library
requirements. Note that at the time of writing this project may resolve to a
development release rather than a stable tag — test before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/attempt_mgmt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/attempt_mgmt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en attempt_mgmt -y
```

## Next step

On its own the module only adds the attempt entity type and field — you make it
useful by defining attempt types and attaching the field. See
[Configuration](../configuration/index.md).
