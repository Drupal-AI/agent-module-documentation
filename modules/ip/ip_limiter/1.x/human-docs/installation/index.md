# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party PHP libraries.
- **Drupal cron** should be running — bans escalate for repeat offenders and
  decay over time via cron, so a working cron keeps the ban lifecycle healthy.

## Install with Composer

From the project root:

```bash
composer require drupal/ip_limiter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_limiter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_limiter -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → System → IP Limiter**
(`/admin/config/system/ip-limiter`). If the rules page loads, the module is
installed. Add a rule and see [Configuration](../configuration/index.md) to tune
it.

> **Upgrading from an early alpha?** From 1.0.0‑alpha3 the module switched to the
> plugin‑based rule system, so if you're coming from 1.0.0‑alpha2 you'll need to
> reconfigure your restrictions.
