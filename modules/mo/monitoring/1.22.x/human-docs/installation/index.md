# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as a
  dependency.

There are no third-party Composer or PHP library requirements for the base module.
(Some individual sensors only become useful when the module they watch — for example
Search API or Commerce — is present, but they stay dormant otherwise.)

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/monitoring -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monitoring -y
```

On enable, Monitoring auto-creates a set of default sensors (cron, watchdog, core
requirements, content, and more). Visit **Reports → Monitoring** to see them, and
**Configuration → System → Monitoring → Sensors** to manage them — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Monitoring ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Monitoring Mail** | `monitoring_mail` | Sends escalation email when a sensor transitions to a bad status. |
| **Monitoring Multigraph** | `monitoring_multigraph` | Aggregates several sensors into one multigraph, for Munin-style graphing. |
| **Monitoring Prometheus** | `monitoring_prometheus` | Exposes all sensor results to Prometheus at a `/metrics` endpoint (adds its own `access monitoring prometheus metrics` permission). |
| **Monitoring Demo** | `monitoring_demo` | A demonstration setup — for evaluation, not production. |
| **Monitoring Test** | `monitoring_test` | Test fixtures used by the module's automated tests; not for production. |

For example, to send alert emails:

```bash
drush en monitoring_mail -y
```

Each submodule requires the base Monitoring module, which is already present once you
have installed it above.

## Grant the permissions

At **People → Permissions**, decide who can see reports and who can administer
sensors — see [Configuration](../configuration/index.md#permissions). Typically
operators get **Monitoring reports** while administrators also get **Administer
monitoring**.
