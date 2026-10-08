# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third-party Composer libraries.
- Optional but recommended for the metrics dashboard: the **Memcache**
  (`drupal/memcache`) or **Redis** (`drupal/redis`) module. The blocking itself works
  without either, but the blocked/allowed counters and last-blocked details are only
  tracked when one of these in-memory cache backends is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/facet_bot_blocker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facet_bot_blocker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facet_bot_blocker -y
```

Once enabled, the request listener is active. Because no configuration ships by
default, the blocking threshold falls back to **1** until you save the settings form
(so a request carrying `f[1]` — the second active facet — is blocked). Review and set
the limit before relying on it in production — see
[Configuration](../configuration/index.md).

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Administer facet bot blocker** — for admins who manage the settings form.
- **Access facet bot blocker dashboard** — for anyone who should see the metrics
  report.
- **Bypass facet bot blocker** — for authenticated/staff roles that legitimately
  browse deep facets and must never be blocked.

## Optional: enable Redis or Memcache for metrics

If you want the dashboard counters populated, install and configure **Redis** or
**Memcache** as a cache backend. Without one, blocking still works, but the dashboard
shows only the current limit with zeroed counts.
