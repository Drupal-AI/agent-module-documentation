# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No other contrib modules and no third‑party Composer or PHP libraries — it builds
  on core's session and CSRF systems.

## Install with Composer

From the project root:

```bash
composer require drupal/anonymous_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anonymous_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymous_token -y
```

There are no submodules. Enabling the module does **not** protect anything on its own
— you opt in per route. Grant the **Administer anonymous csrf token** permission to
the administrator who manages the single‑use toggle, then see
[Configuration](../configuration/index.md) for how to wire a route and generate a
token.
