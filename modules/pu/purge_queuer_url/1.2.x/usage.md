<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URLs queuer extends the Purge module to invalidate by **URL** rather than by cache tag, using a traffic registry that records which URLs served which tags so the right pages can be purged from a cache that does not understand tags.

---

Purge's native currency is the cache tag, which is exactly right for a reverse proxy that supports tag-based invalidation. Plenty of real caches do not: a CDN or an older Varnish configuration can often only be told to drop a specific URL. Bridging the two requires knowing which URLs would have been affected by a tag, and that is what this module builds. `src/StackMiddleware` observes traffic as it is served and records the URL-to-tag relationship in the **traffic registry** (`TrafficRegistry`, `TrafficRegistryInterface`), so when a tag is invalidated the queuer can enumerate the URLs that carried it and queue those instead. `src/Plugin` supplies the queuer, `src/Form` the configuration, `src/Commands` plus `drush.services.yml` the Drush integration, and there is a `purge_queuer_url.post_update.php` and a maintained `CHANGELOG.md`. Composer requires `purge ^3.4`; core `^10 || ^11`. The cost to be aware of is that the registry grows with traffic and must be maintained — it is a database table written on requests, so its size and pruning behaviour matter on a busy site, and the middleware sits in the request path.

---

- Purge a CDN that cannot invalidate by cache tag.
- Invalidate specific URLs after a content change.
- Bridge Drupal's tag model to a URL-based cache.
- Record which URLs served which cache tags.
- Queue paths for an external purger.
- Support an older Varnish configuration.
- Purge a landing page when a referenced node changes.
- Drive invalidation from Drush in a deploy.
- Keep a CDN in step with editorial changes.
- Reduce over-purging by targeting URLs.
- Handle a cache with no tag support.
- Queue URLs discovered from real traffic.
- Combine URL and tag queuers.
- Invalidate paginated listing URLs.
- Purge after a bulk content operation.
- Support a multi-CDN setup.
- Diagnose which URLs a tag affects.
- Reduce cache-miss storms after deployment.
