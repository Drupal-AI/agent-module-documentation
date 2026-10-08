# Nuxt Multi Cache — manual setup guide

**Nuxt Multi Cache** (`nuxt_multi_cache`) integrates Drupal with the
[`nuxt-multi-cache`](https://www.drupal.org/project/nuxt_multi_cache) module on a
decoupled **Nuxt** front end, so the two caches stay in step. When content changes
in Drupal (the backend/CMS), Drupal sends purge requests to the Nuxt cache
endpoint and the matching front‑end cache entries are cleared — so visitors do not
keep seeing stale pages after an editor publishes an update.

This is a **performance / decoupled‑integration** feature, not a content‑access
one: it has no role in who can see what, it simply coordinates cache invalidation
between Drupal and Nuxt. It fits headless/decoupled setups where a Nuxt front end
uses `nuxt-multi-cache`.

The module ships two submodules — **`graphql_nuxt_multi_cache`** (for sites serving
the front end through GraphQL) and **`nuxt_multi_cache_purger`** (the purge
integration) — and it provides its own permissions. It needs configuring: you tell
it the Nuxt cache endpoint and the credentials used to authenticate purge
requests.

> **Security note.** Drupal sends purge requests to the Nuxt cache endpoint, so
> that endpoint should be **authenticated** with a shared token/secret — only
> Drupal should be able to trigger purges. Treat the token as a secret: store it in
> an environment variable / Key entity rather than in plain configuration. See
> [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — set the Nuxt cache endpoint and the
   purge credentials, and store the token securely.

## Where it lives in the admin menu

Once enabled, configure the Nuxt cache endpoint and purge credentials from the
module's settings, then let content changes in Drupal drive cache invalidation on
the Nuxt front end. See [Configuration](configuration/index.md) for the specifics.
