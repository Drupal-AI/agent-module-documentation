<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Rate Limits

## The config entity
`rate_limit_config` (class `Drupal\rate_limits\Entity\RateLimitConfig`, config prefix
`rate_limits.rate_limit_config`, admin permission `administer site configuration`). Managed at
`/admin/structure/rate_limit_config` (collection route `entity.rate_limit_config.collection`,
the module's `configure` route). Add/edit form fields (`RateLimitConfigForm`):

- **Label** / **Machine id**.
- **User Flood per Route** (`user_flood_route`) and **Global User Flood** (`user_flood_global`)
  — each a fieldset of five values (defaults pulled from core `user.flood` config):
  - `uid_only` (bool) — when checked, the user identifier is the uid alone (IP not used).
  - `ip_limit` / `ip_window` — max IP-based hits and window (seconds).
  - `user_limit` / `user_window` — max user-based hits and window (seconds).
- **Route Tags** (`tags`) — textarea, **one tag per line**; stored as an array
  (`array_unique(explode("\r\n", ...))`).

Schema: `rate_limits.rate_limit_config.*` with a reusable `user_flood` mapping (see
`config/schema/rate_limit_config.schema.yml`).

## How a request is matched and limited (`RequestSubscriberCheckLimits::onRequest`)
1. The subscriber resolves the request to a route (`router.no_access_checks`); on no match it
   returns (no limiting).
2. `loadConfig($route)` reads `$route->getOption('tags')`. If the route has **no** tags → no
   limit. Otherwise it loads all `rate_limit_config` entities and returns the first whose tags
   are **all** contained in the route's tags.
3. If the current user has permission `skip rate limit checks` → return (no limiting).
4. Four flood checks run in order; the first failure sets a `429 Too many requests` response
   and stops:
   - **route IP**: `flood->isAllowed('rate_limit_ip:'.md5(routePath), ip_limit, ip_window)`
   - **route user**: keyed on the user identifier (below)
   - **global IP**: event `rate_limit_global:'.md5(join(',',tags))`
   - **global user**: same global event, user identifier
   Each successful check also calls `flood->register(...)` to record the hit.

### Identifiers
- **IP checks** (`checkIp`) pass no identifier to `flood->isAllowed()`, so core Flood uses its
  default identifier = the request's client IP (`Request::getClientIp()`; honors trusted-proxy
  `X-Forwarded-For` only if the site configures trusted proxies).
- **User checks** (`checkUser`) apply only to authenticated users (anonymous returns allowed).
  Identifier is `uid` when `uid_only` is TRUE, else `uid.'-'.clientIP`. Per code comments,
  `uid_only` is "most secure"; the uid+IP default is "more resistant to denial-of-service that
  could lock out all users with public user names".

## Tagging routes (prerequisite)
Limits apply only to routes that declare `options.tags`. Tag your own routes in
`*.routing.yml`, or tag another module's routes with a `RouteSubscriber`
(`alterRoutes()` → `$route->setOption('tags', [...])`). Example:
```yaml
my_module.api:
  path: '/api/thing'
  options:
    tags: ['first_tag', 'second_tag']
  defaults: { _controller: '...' }
  requirements: { _permission: 'access content' }
```
A config whose `tags` = `['first_tag']` (a subset) will match this route; a config requiring a
tag the route lacks will not. Set routes `no_cache: TRUE` if you need the subscriber to run on
every hit (cached responses may not reach the kernel request check).
