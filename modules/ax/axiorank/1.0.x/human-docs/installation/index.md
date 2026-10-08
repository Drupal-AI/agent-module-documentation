# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- An **AxioRank account / site key** — the module verifies requests against the
  external AxioRank service, so you need a site key from AxioRank to use it.

There are no other module dependencies listed.

## Install with Composer

From the project root:

```bash
composer require drupal/axiorank -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/axiorank -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en axiorank -y
```

After enabling, set your AxioRank site key and choose a posture on the settings
form — start in **monitor** mode to observe before enforcing. See
[Configuration](../configuration/index.md).
