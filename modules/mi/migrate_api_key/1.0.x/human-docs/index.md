# Migrate API Key — manual setup guide

**Migrate API Key** (`migrate_api_key`) is a small developer helper for
Migrate‑based imports. It provides a migration **source plugin** that appends an
API key to the source URLs your migration fetches, so you can pull content from a
remote endpoint that requires a key passed as a query parameter. It was built for
**Drupal‑to‑Drupal** migrations — fetching content from another Drupal site's
JSON:API / REST endpoint that is protected by an API key — but it works against
any URL‑based source that expects a key in the query string.

The problem it solves is keeping the key out of your committed migration YAML.
Instead of hard‑coding `?api-key=…` into the source URLs, you point the migration
at this plugin, and it reads the key at run time from a **secret / environment
variable** and appends it to each request. If the key is missing it logs a
warning and continues rather than failing outright.

There is **no settings form** — the module is consumed entirely from migration
configuration (YAML) plus one environment variable. It depends on **Migrate Plus**
(`migrate_plus`) and runs on **Drupal 11**. It has no admin UI and no permissions
of its own.

> **Security note.** The key is placed in the **URL query string**, which can end
> up in server logs, browser history, and referrer headers. Treat it as
> sensitive: only migrate over **HTTPS**, use a dedicated low‑privilege "API"
> role/key on the source site (view‑only, never an admin's key), and store the
> key as a secret — never commit it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate Plus dependency.

There is **no configuration page** for this module. Setup is the environment
variable plus a change to your migration YAML, both described below.

## How to use it

### 1. Provide the API key as a secret

The plugin looks for the key named **`MIGRATE_API_KEY`**. It checks a Pantheon
secret first (`pantheon_get_secret()`), then falls back to a normal environment
variable (`getenv()` / `$_ENV`). Set it in whichever way your hosting supports —
and never commit it.

With DDEV, store it as an environment variable using the built‑in dotenv helper
(this writes `.ddev/.env`, which must stay out of version control), then restart
so the container picks it up:

```bash
ddev dotenv set .ddev/.env --migrate-api-key=<value>
ddev restart
```

The flag `--migrate-api-key` becomes the environment variable `MIGRATE_API_KEY`
inside the web container. (If you set an environment variable another way, restart
your local environment afterwards so the new value is visible to Drush.)

### 2. Point the migration source at the plugin

In your migration's YAML, change the source plugin from the usual `url` to
`migrate_api_key_url_plugin`:

```yaml
id: example_migration
label: "Example Migration"
migration_group: example_group
source:
  plugin: migrate_api_key_url_plugin
  urls:
    - "https://example.com/api/data"
...
```

At run time the plugin transforms `https://example.com/api/data` into
`https://example.com/api/data?api-key=<your key>`.

> In the **1.0.x** series you may also need to add the migration tag
> `add_api_key`; from 1.1.x that tag is no longer required.

### 3. Run the migration as usual

```bash
drush migrate:import example_migration
```

If the key is unset or empty, the migration still runs but a warning is written to
the log — check **Reports → Recent log messages** if requests come back
unauthorised.
