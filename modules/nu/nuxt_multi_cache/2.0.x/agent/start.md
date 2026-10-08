<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nuxt Multi Cache — agent index

Integrates Drupal with the **nuxt-multi-cache** module — coordinate **cache invalidation** with a decoupled
Nuxt front end (purge Nuxt cache on content change). `graphql_nuxt_multi_cache`/`nuxt_multi_cache_purger`
submodules; provides permissions. Version **2.0.3**. Core `^10||^11`.

**Security:** authenticate the Nuxt purge endpoint (shared token so only Drupal can purge); store the token
as a secret. Performance/decoupled — no content-access role.
