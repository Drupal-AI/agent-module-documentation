# Installation

## Requirements

- **Drupal 10.3, 11 or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **Search API** (`search_api`) — the only hard dependency. AI Index Health reads
  Search API's tracker and datasource structures to work out what is stale or
  missing.
- **Optional integrations**, all detected automatically and used only if present:
  the **AI** module (`ai`), **AI Search** (`ai_search`) and **AI Model Registry**
  (`ai_model_registry`). Without them the module still runs its Search-API-level
  checks; with them it can also compare vector sizes against the provider's current
  model and surface a model end-of-life signal.

There is no provider API key to configure in this module itself — it monitors the
indexes your AI Search setup already produces.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_index_health -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_index_health -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_index_health -y
```

There are no submodules.

## Grant the permission

At **People → Permissions**, grant **Administer AI index health**
(`administer ai index health`) to the roles that should see the dashboard and run
requeues. This is a restricted permission and both the dashboard and the requeue
action are gated by it — keep it to trusted administrators. The requeue action is
additionally CSRF-protected.

Once enabled, open the dashboard at
**Configuration → Search and metadata → AI Index Health** or run the Drush report
— see [How to use it](../index.md#how-to-use-it).
