# Configuration

Setting up a working limit takes two pieces that must line up: **tags on the
routes** you want to protect, and a **Rate Limit Config entity** whose tags match
those routes.

## 1. Tag the routes you want to limit (developer step)

A route only participates in rate limiting if it declares one or more `tags` in its
route options. For your own module's routes, add them in the `*.routing.yml`:

```yaml
my_module.api:
  path: '/api/thing'
  options:
    tags: ['first_tag', 'second_tag']
  defaults:
    _controller: '\Drupal\my_module\Controller\ThingController::get'
  requirements:
    _permission: 'access content'
```

To tag routes contributed by another module, add a `RouteSubscriber` whose
`alterRoutes()` calls `$route->setOption('tags', [...])`. If a route's response is
cached, set `no_cache: TRUE` so the rate-limit check actually runs on every hit.

## 2. Create a Rate Limit Config entity

Go to **Structure → Rate Limit Config** (`/admin/structure/rate_limit_config`) and
add a config. The form has:

- **Label** and **Machine id** — to identify this config.
- **Route Tags** — a textarea, **one tag per line**. A config matches a route when
  **all** of the config's tags are present on that route's tags. (So a config
  tagged only `first_tag` will match the example route above, which has both
  `first_tag` and `second_tag`.)
- **User Flood per Route** — the per-route limit profile.
- **Global User Flood** — the global limit profile (shared across all routes that
  match the tag).

Each of the two profiles is a small fieldset of five values (their defaults come
from core's `user.flood` config):

- **IP limit** and **IP window** — the maximum number of IP-based hits and the
  time window in seconds.
- **User limit** and **User window** — the maximum number of user-based hits and
  the window in seconds.
- **uid only** — a checkbox affecting how authenticated users are identified (see
  below).

## The four limit "buckets"

On each matching request the module checks four buckets in order, and the first one
over its limit triggers a 429:

1. **Per-route IP** — this route, counted per client IP.
2. **Per-route user** — this route, counted per authenticated user.
3. **Global IP** — across all routes sharing the tag, per client IP.
4. **Global user** — across all routes sharing the tag, per authenticated user.

Anonymous visitors skip the two *user* buckets (they have no user id), but the *IP*
buckets still apply to them.

## IP vs. user identity, and `uid only`

- **IP checks** use core Flood's default identifier — the request's client IP.
  (Behind a proxy, this only honours `X-Forwarded-For` if your site is configured
  with trusted proxies.)
- **User checks** apply only to logged-in users. By default the identifier is the
  user id combined with the client IP, which the module's authors describe as more
  resistant to a denial-of-service that could otherwise lock out a named user.
  Ticking **uid only** keys purely on the user id regardless of IP — better behind
  shared NAT or proxies, and described as the most secure option.

## Exempting trusted roles

The **Skip rate limit checks** permission (*People → Permissions*) exempts any role
that holds it from **all** limits — the check happens first, before any bucket is
evaluated. Grant it to trusted internal or service roles (cron, monitoring,
authenticated API clients you trust) that must not be throttled. It only loosens
enforcement; it grants no other capability. Note that *managing* the limit entities
themselves is governed by the separate **Administer site configuration**
permission, not by this one.

## Turning limits off

To stop limiting a route, remove its tags or delete the matching Rate Limit Config
entity. You can also keep several config entities, each targeting a different tag
set, so different route groups get different limits.
