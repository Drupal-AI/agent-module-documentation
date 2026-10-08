# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1 || ^12`).
- The **`previousnext/php-prometheus`** PHP library (`^1.4.0`), which serializes the
  metrics into the Prometheus exposition format. Composer installs it automatically
  when you require the module.
- For the Drush command, **Drush 13** or newer (the module conflicts with Drush
  below 13.7).

## Install with Composer

From the project root:

```bash
composer require drupal/prometheus_exporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`previousnext/php-prometheus` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prometheus_exporter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prometheus_exporter -y
```

Once enabled, the settings form is available at **Configuration → System →
Prometheus Exporter**. Remember that **all collectors start disabled** and the
`/metrics` endpoint is **closed** (no role has the permission yet) — so nothing is
exposed until you configure it. See [Configuration](../configuration/index.md).

## Optional submodules — enable only what you need

Three submodules ship with the module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Comment metrics** | `prometheus_exporter_comment` | A `comment_count` collector. |
| **Update status metrics** | `prometheus_exporter_update` | An `update_status` collector reporting available (security) updates from the Update Manager. |
| **Token access** | `prometheus_exporter_token_access` | Lets a static token (in the query string or an `Authorization: Bearer` header) stand in for the *Access Prometheus metrics* permission, so a scraper can authenticate with a token instead. It has its own default‑open caveat — read that submodule's docs before enabling. |

Enable any of them individually, for example:

```bash
drush en prometheus_exporter_update -y
```

## Verify it worked

Go to **Configuration → System → Prometheus Exporter**
(`/admin/config/system/prometheus_exporter`) — you should see the list of collectors,
all disabled. Or run `drush prometheus:export`, which prints the output of every
enabled collector on the CLI (and bypasses the endpoint permission). With no
collectors enabled yet, that output will be empty — that's expected.
