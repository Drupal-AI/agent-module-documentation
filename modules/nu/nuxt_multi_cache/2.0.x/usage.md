<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nuxt Multi Cache provides integration with the nuxt-multi-cache module, coordinating cache invalidation for a Nuxt front end.

---

Nuxt Multi Cache integrates Drupal with the `nuxt-multi-cache` module — coordinating cache invalidation
between Drupal (the backend/CMS) and a decoupled Nuxt front end, so when content changes in Drupal the
corresponding Nuxt cache entries are purged. It ships `graphql_nuxt_multi_cache` and `nuxt_multi_cache_purger`
submodules and provides its own permissions, in the Web services package.

Use it in decoupled/headless setups with a Nuxt front end that uses nuxt-multi-cache. The security-relevant
point: it sends purge requests to the Nuxt cache endpoint — that endpoint should be authenticated (a shared
token/secret) so only Drupal can trigger purges, and the token should be stored as a secret. It is a
performance/decoupled-integration feature with no content-access role. Configure the Nuxt cache endpoint and
purge credentials.

---

- Integrate nuxt-multi-cache.
- Coordinate cache invalidation with Nuxt.
- Purge Nuxt cache on content change.
- Ship graphql/purger submodules.
- Provide its own permissions.
- Authenticate the Nuxt purge endpoint.
- Store the purge token as a secret.
- Serve decoupled/headless setups.
- Have no content-access role.
- Configure the Nuxt cache endpoint.
- Invalidate front-end cache.
- Purge decoupled cache.
- Handle headless cache.
- Configure purge credentials.
- Coordinate caches.
- Purge on update.
- Integrate with Nuxt.
- Handle cache purging.
- Configure the integration.
- Invalidate Nuxt cache.
