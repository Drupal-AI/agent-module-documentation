# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or higher**.
- The **`softcreatr/jsonpath`** library, pulled in automatically by Composer —
  it powers the JSONPath expressions used in field mappings.
- A **working cron** — inbound and outbound webhooks are queued and processed on
  cron. For near-real-time delivery, run a dedicated queue runner.

## Install with Composer

Installing with Composer is required, so the JSONPath library is fetched too.
From the project root:

```bash
composer require drupal/entity_webhook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the JSONPath
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_webhook -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core (inbound) module first:

```bash
drush en entity_webhook -y
```

## Submodules — enable only what you need

| Submodule | What it adds |
|-----------|--------------|
| **Entity Webhook Broadcast** | Outbound webhooks — watch entity create/update/delete events and POST a JSON payload to an external URL, with HMAC signing and retry/backoff. |
| **Entity Webhook Polling** | Scheduled polling — call external APIs on a cron schedule and feed the results through the same processing pipeline as inbound webhooks. |

Enable whichever you need, for example:

```bash
drush en entity_webhook_broadcast -y
```

## Secrets

If you use HMAC or API-key verification (inbound) or HMAC signing (outbound),
choose a strong, random shared secret and keep it out of version-controlled
configuration exports. Always serve webhook endpoints over **HTTPS**.

## Verify it worked

Visit **Configuration → Services → Entity Webhook**
(`/admin/config/services/entity-webhook/endpoints`). If the endpoint listing
loads, the core module is active. Before sending any real traffic, follow
[Configuration](../configuration/index.md) — and select a verification plugin on
every Source Type.
