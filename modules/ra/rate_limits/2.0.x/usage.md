<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Applies configurable per-request rate limits to any set of routes, enforced server-side on every request through Drupal core's Flood service, returning HTTP 429 when a limit is exceeded. Routes are selected by matching **route `tags` options** against a Rate Limit Config entity.

---

The module defines a `rate_limit_config` config entity (managed at *Structure › Rate Limit Config*, `/admin/structure/rate_limit_config`) that carries a set of **route tags** plus two flood profiles: a **per-route** profile (`user_flood_route`) and a **global** profile (`user_flood_global`). A `KernelEvents::REQUEST` subscriber (`RequestSubscriberCheckLimits`) matches the incoming request to its route, and if the route declares one or more `tags` in its route `options`, finds the config whose tags are all present on the route. It then checks four flood buckets via `\Drupal::flood()`: per-route IP limit, per-route user limit, global IP limit, global user limit — each with its own limit/window. IP checks use core Flood's default identifier (the request client IP); user checks key on the authenticated user's uid (optionally combined with IP unless `uid_only` is set). Any bucket over its limit short-circuits the request with a `429 Too many requests` response; otherwise a flood event is registered and the request proceeds. Users holding the `skip rate limit checks` permission bypass all limits. Because a route only participates if a developer (or another module) tags it, the module ships with no active limits until you both tag routes and create a config. Provides one permission and a config schema; no Drush commands, no services beyond the subscriber.

---

- Throttle a custom API/JSON endpoint to N requests per IP per time window.
- Rate-limit a login or password-reset route to slow credential-stuffing.
- Cap requests to an expensive report/search route site-wide with a global limit.
- Apply both a per-IP and a per-authenticated-user limit to the same route.
- Group several routes under one shared limit by giving them the same tag set.
- Enforce a global limit across all routes matching a tag (e.g. all `webhook` routes).
- Exempt trusted roles from limits via the `skip rate limit checks` permission.
- Use `uid_only` to limit per user regardless of IP (better behind shared NAT/proxies).
- Use the default uid+IP identifier to resist DoS that would otherwise lock out a named user.
- Set independent limit/window pairs for IP vs user abuse on the same route.
- Return a standards-compliant 429 to clients hitting an abused endpoint.
- Protect a form-submission route from rapid automated resubmission.
- Limit a file-download route to curb scraping.
- Apply a strict short-window burst limit plus a looser long-window global limit together.
- Rate-limit routes contributed by another module by tagging them via a route subscriber.
- Tune limits per environment by editing the config entity (or config override).
- Add several Rate Limit Config entities, each targeting a different tag set.
- Give an internal admin route a very high limit while keeping public routes tight.
- Reuse core's Flood backend so limits share the site's flood storage and cleanup.
- Quickly disable a route's limits by removing its tags or deleting the config.
