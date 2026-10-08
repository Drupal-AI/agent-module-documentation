# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- No modules outside Drupal core are required, and there are no third‑party PHP
  library requirements.
- To use the Entity Browser tweak, you also need the patch from drupal.org issue
  3035036 applied (see the module's README) and the Entity Browser module in use.

This is the 2.0.x branch, covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/config_tweak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_tweak -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_tweak -y
```

## Verify it worked

Go to **Configuration → Development → Config tweak**
(`/admin/config/development/config_tweak`) and confirm the settings form loads with
its tweak toggles. Then follow [Configuration](../configuration/index.md) to enable
the tweaks you want and opt individual fields or widgets in.
