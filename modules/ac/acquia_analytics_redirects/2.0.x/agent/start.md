<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Analytics Redirects (acquia_analytics_redirects) — agent index

Single response event subscriber. When a 301/302 response carries the request header
`X-Acquia-Stripped-Query` (analytics query params — `utm_*`, `gclid`, … — that Acquia Cloud's
Varnish strips for cache performance and forwards to the backend), it re-applies that query string
onto the redirect's target and re-issues the redirect. **No config, no permissions, no admin UI, no
routes, no plugin types, no hooks, no drush, no services API to call** — installing + enabling is the
whole setup. Built for Acquia Cloud (Varnish) sites; on any other host the header is normally absent,
so the module is a no-op. (Per the project page, core's Internal Page Cache module must be
disabled/uninstalled for it to take effect.)

- **Full behavior, the merge rule, the Vary header, and how to operate/verify it** →
  [api/event-subscriber.md](api/event-subscriber.md)

## What it actually is

Behavior — `src/EventSubscriber/AnalyticsRedirectsEventSubscriber.php`, method
`getHeaderAcquiaStrippedQuery(ResponseEvent $event)`, subscribed to `KernelEvents::RESPONSE` at
priority `-1024` (runs very late in the response pipeline):

- Acts only when `$response->getStatusCode()` is `301` or `302`.
- Reads request header `X-Acquia-Stripped-Query`; proceeds only if it is non-empty.
- `UrlHelper::parse()` the current target URL, then rebuilds the target as
  `$url_parts['path'] . '?' . UrlHelper::buildQuery(array_merge($stripped_params, $url_parts['query']))`.
  The scheme/host/path are inherited from the already-issued redirect; the header's params are
  **merged with the target's own query** and **the target's params win on key collision** (so a
  destination that already carries `?gclid=…` is not overwritten). Values pass through
  `UrlHelper::buildQuery`, so they are url-encoded.
- Preserves the target's `#fragment` (re-appended after the query) when present.
- Appends `X-Acquia-Stripped-Query` to the response `Vary` header, so Varnish stores a distinct
  cache entry per stripped-query value.
- Replaces the response with
  `new TrustedRedirectResponse($target, $status, $response->headers->all())`.

## Facts

- Depends on: nothing (`composer.json` `require` is empty; `.info.yml` declares no `dependencies`).
- Core: `^10.3 || ^11 || ^12`. Package: `performance`. License GPL-2.0-or-later. Version 2.0.2.
- Settings page / `configure` route: none. No permissions, no drush commands, no config schema, no
  plugin types, no hooks, no libraries, no templates, no JS/CSS.
- One service: `acquia_analytics_redirects_subscriber` →
  `\Drupal\acquia_analytics_redirects\EventSubscriber\AnalyticsRedirectsEventSubscriber`, tagged
  `event_subscriber`. It is not an API — there is nothing to call from your own code.

## Key facts (real machine names)

- Event subscriber service id: `acquia_analytics_redirects_subscriber`.
- Subscribed event / priority: `KernelEvents::RESPONSE` at `-1024`.
- Method: `getHeaderAcquiaStrippedQuery(ResponseEvent $event)`.
- Request header consumed: `X-Acquia-Stripped-Query`. Response `Vary` header added:
  `X-Acquia-Stripped-Query`.
- HTTP statuses handled: `301`, `302`. Response class emitted:
  `Drupal\Core\Routing\TrustedRedirectResponse`.
- No routes, no config keys, no permissions, no plugin ids, no libraries.
