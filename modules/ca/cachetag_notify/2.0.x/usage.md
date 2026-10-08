<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CacheTag Notify registers a cache tags invalidator that POSTs the list of invalidated cache tags, as a JSON body, to a URL you configure. This lets an external system — a CDN, a reverse proxy, a static-site rebuild hook — react to Drupal cache invalidations.

Use it to bridge Drupal's cache-tag invalidations to infrastructure that lives outside Drupal.
---
Enable with `drush en cachetag_notify`. Set the target endpoint at `/admin/config/system/cachetag_notify` (route `cachetag_notify.settings`), gated by the core `administer site configuration` permission.

The invalidator service (`src/CacheTagsInvalidator.php`, tagged `cache_tags_invalidator`) is called on every cache-tag invalidation; if an endpoint is configured it does `httpClient->post($endpoint, ['body' => json_encode($tags)])` using Guzzle, logging client/server/connect exceptions. TLS verification is left at Guzzle defaults (enabled).
---
- Notify a CDN when Drupal cache tags are invalidated.
- Trigger reverse-proxy purges from cache-tag events.
- Kick off a static-site rebuild on content changes.
- POST invalidated tags as JSON to an external service.
- Bridge Drupal cache invalidation to external infra.
- Configure the notify endpoint via an admin form.
- Integrate with Varnish/Fastly-style purge webhooks.
- Log delivery failures via watchdog.
- Send tag lists on every invalidation automatically.
- Decouple cache purging from Drupal internals.
- Support headless setups needing purge signals.
- Keep an edge cache in sync with Drupal.
- Fire a webhook per invalidation batch.
- Use Guzzle with default TLS verification.
- Restrict endpoint configuration to admins.
- Coordinate multi-tier caches from one signal.