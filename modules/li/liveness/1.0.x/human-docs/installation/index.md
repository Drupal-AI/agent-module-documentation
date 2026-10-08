# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** — required, both for the `drush liveness:check` command and because the
  scheduled checks run from the command line.
- No other module dependencies.

There are no PHP library requirements beyond a normal Drupal/Drush environment.

## Install with Composer

From the project root:

```bash
composer require drupal/liveness -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/liveness -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en liveness -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Development → Performance →
Liveness** (`/admin/config/development/performance/liveness`). You should see the
settings form for environment URLs and notification emails. Then run a manual check
to confirm the plumbing works:

```bash
drush liveness:check https://example.com example-environment
```

Once that returns cleanly, move on to [Configuration](../configuration/index.md) to
set up your environments and schedule the checks.
