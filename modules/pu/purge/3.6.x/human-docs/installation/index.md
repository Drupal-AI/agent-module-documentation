# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **A purger module for your cache.** Purge ships no purger itself, so on its own it
  can queue invalidations but has nothing to send them to. Install the contrib
  module that integrates with your reverse proxy or CDN — for example a Varnish,
  Fastly, Akamai, or CloudFront purger — so a purger plugin is available to enable.

There are no hard module dependencies and no third‑party Composer library
requirements for Purge core itself.

## Install with Composer

From the project root:

```bash
composer require drupal/purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install your proxy/CDN purger module with a second
`composer require` for that project.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge -y
```

Enabling Purge core alone doesn't invalidate anything — you next enable the
pipeline submodules below and configure the plugins. See
[Configuration](../configuration/index.md).

## Submodules — the pipeline pieces

Purge ships several optional submodules. A typical working setup enables a queuer,
one or more processors, and the UI; the purger comes from your separate proxy/CDN
module.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Purge UI** | `purge_ui` | The admin dashboard at `/admin/config/development/performance/purge` for adding, ordering, and removing plugins and watching the queue. Enable this unless you configure everything via Drush. |
| **Core tags queuer** | `purge_queuer_coretags` | Automatically queues every cache tag Drupal invalidates — the usual way to feed the queue. |
| **Cron processor** | `purge_processor_cron` | Drains the queue on cron runs. |
| **Late runtime processor** | `purge_processor_lateruntime` | Drains the queue at the end of each request, for lower-latency invalidation. |
| **Tokens** | `purge_tokens` | Adds token replacement for use in purger request configuration. |
| **Drush** | `purge_drush` | The `p:*` Drush commands for driving Purge from the CLI. |

For example, a common starting point:

```bash
drush en purge_ui purge_queuer_coretags purge_processor_cron -y
```

## Verify it worked

With Purge UI enabled, go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`). The dashboard's diagnostics will
tell you what's still missing — most often "no purger installed" until you add and
enable a purger from your proxy/CDN module. You can also run `drush p:diagnostics`
from the CLI.
