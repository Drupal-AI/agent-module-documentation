# Sync UUIDs — manual setup guide

**Sync UUIDs** (`sync_uuids`) provides a single Drush command that
**synchronizes the UUIDs** of configuration (and entities) between environments.
It exists to solve a specific, frustrating problem in Drupal's configuration
management: config is matched between environments by its **UUID**, not its name,
so when the same configuration ends up with different UUIDs on different servers,
a config import fails with conflicts.

That mismatch happens easily — for example when you deploy code to several
servers and a module that ships configuration installs on each one, generating a
fresh UUID for its config on every environment; or when config was created
separately on different sites. Sync UUIDs reconciles those UUIDs so the
configuration lines up and imports cleanly again.

This is a developer/deployment tool that runs entirely through Drush — there is
no settings page and no runtime access role. Because it **changes UUIDs**, run it
deliberately and understand its effect: aligning UUIDs changes how configuration
and entities are matched on import, so it belongs in a controlled deployment or
repair process, not as a routine background task. It depends on core's
Configuration Manager module and supports Drupal 8, 9, 10 and 11.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, run the sync from the command line:

```bash
drush sync-uuids
```

(`drush su` works as a short alias.) Run it as a deliberate step in a deployment
or repair, then import your configuration as usual. Because it rewrites UUIDs,
it is wise to have a database backup before running it on an important
environment.
