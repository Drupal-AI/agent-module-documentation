<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rate Limits — agent index

Per-route request rate limiting enforced by a `KernelEvents::REQUEST` subscriber using core's
Flood service. A `rate_limit_config` config entity ties **route tags** to per-route + global
flood profiles. Config UI: `/admin/structure/rate_limit_config`
(route `entity.rate_limit_config.collection`, admin permission `administer site configuration`).

- **The config entity, the four flood buckets, how routes are matched by tags, tagging a route,
  IP vs user identifiers, `uid_only`** → [configure/rate-limit-config.md](configure/rate-limit-config.md)
- **The `skip rate limit checks` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Enforcement is server-side in `RequestSubscriberCheckLimits::onRequest()`. A route is only
  limited if its route `options.tags` contains **all** tags of a config entity.
- Four checks per matching request: route-IP, route-user, global-IP, global-user. Over-limit →
  `Response('Too many requests', 429)`. IP checks use core Flood's default identifier
  (request client IP); user checks key on uid (or `uid`+client IP unless `uid_only`).
- Anonymous users skip the *user* checks (IP checks still apply). Holders of
  `skip rate limit checks` skip everything.
- No active limits until you both tag routes AND create a config entity.
