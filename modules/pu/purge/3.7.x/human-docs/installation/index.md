# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No contributed module dependencies, third‑party Composer packages, or PHP
  extensions are required by the base module.
- **A purger module for your cache layer** — Purge itself does not talk to any
  cache. You'll install one separately (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and the pieces you need

Purge is highly modular. Most sites enable the base module plus several submodules.
A typical starting point:

```bash
drush en purge purge_ui purge_drush purge_queuer_coretags purge_processor_cron -y
```

## Submodules

Enable only what your setup calls for:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Purge UI** | `purge_ui` | The admin dashboard at *Configuration → Development → Performance → Purge* for configuring the whole pipeline. |
| **Purge Drush** | `purge_drush` | Historically provided the `p:*` Drush commands (invalidate, queue-work, queue stats, add/remove plugins). On modern Drush these commands ship in the base module, so this submodule mainly exists for backward compatibility. |
| **Core tags queuer** | `purge_queuer_coretags` | Automatically queues every cache tag Drupal invalidates — the usual way to feed the queue. |
| **Cron processor** | `purge_processor_cron` | Drains the queue on cron runs. |
| **Late runtime processor** | `purge_processor_lateruntime` | Drains the queue at the end of each request, for low-latency setups. |
| **Purge Tokens** | `purge_tokens` | Token replacement support in purger requests. |

## Install a purger

Purge coordinates invalidation but performs none itself — **you must add a purger
module** for your reverse proxy or CDN. Common choices include `varnish_purge`,
`fastlypurger`, `cloudflare`, `acquia_purge`, `cloudfront_purger`, and `keycdn`. If
no module supports your cache and it can be invalidated over HTTP, use the generic
`purge_purger_http`. Install the appropriate one with Composer, enable it, and
configure it from the Purge dashboard.

> **Security note:** Purger modules often need API tokens or credentials for your
> CDN. Keep those out of version control — store them in an environment variable
> (via DDEV's dotenv) and, where the purger supports it, reference a Key entity
> rather than committing secrets into configuration.

## Verify it worked

With **Purge UI** enabled, go to **Configuration → Development → Performance →
Purge** (`/admin/config/development/performance/purge`). The dashboard should load
and show diagnostic checks — initially it will warn that no purger is installed,
which resolves once you add and configure one. You can also confirm the CLI is ready
with `drush p:diagnostics` (with `purge_drush` enabled).
