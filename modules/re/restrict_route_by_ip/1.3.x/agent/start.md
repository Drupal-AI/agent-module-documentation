<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict route by IP (restrict_route_by_ip) — agent index

Limits Drupal routes to an allowlist of IP addresses. Rules are `restrict_route`
**configuration entities** managed at `/admin/config/system/restrict_route_by_ip`, gated by the
`admin restrict route by ip` permission (`restrict access: true`). Installed version **1.3.0**,
core `^10 || ^11`, package Administration. No dependencies, no Drush commands.

## What it actually does

- Each **`restrict_route` config entity** holds: `label`, machine `id`, a single `route` target,
  a list of `ips`, and an enabled `status`.
- On every route rebuild, `RouteSubscriber::alterRoutes()`
  (`src/Routing/RouteSubscriber.php`) resolves each enabled entity's `route` target to concrete
  route names and, for each, sets `_custom_access` →
  `restrict_route_by_ip.services_access_checker::access` and the `no_cache` route option.
- `ServicesAccessCheck::access()` (`src/Access/ServicesAccessCheck.php`) returns
  `AccessResult::allowedIf(!userIpIsRestricted())`. The real logic is
  `RestrictIpService::userIpIsRestricted()` (`src/Service/RestrictIpService.php`): it takes the
  current route's matching entity, reads the client IP via **`Request::getClientIp()`**, and
  allows the request if the IP matches **any** entry in the entity's `ips`; otherwise access is
  denied (403). Match-any-to-allow, deny-by-default once a non-empty list is present.

## The `route` target — four syntaxes (resolved in `getAllRouteNamesAndPath()`)

1. **Route name** — exact, e.g. `user.login`. Matches only that one route.
2. **Path** — contains `/`, e.g. `/user/login`. Converted to an **unanchored** regex `#/user/login#`
   and matched against every registered route's path (placeholders replaced with a literal token).
   Unanchored means it matches any route whose path *contains* the string — it over-matches, never
   under-matches.
3. **Path with `%` wildcard** — e.g. `/admin/%/content` → `%` becomes `.+`.
4. **Regex** — a string wrapped in `#…#`, applied directly to route paths.

The add/edit form previews the resolved routes live (AJAX to
`restrict_route_by_ip.impacted_path`). "Impacted routes" = route **names**, not paths.

## IP / range formats (`checkRangeIp()`)

Single IP (`1.2.3.4`), CIDR (`1.2.3.0/24`), hyphen range (`1.2.3.0-1.2.3.255`), and `*` wildcard
(`1.2.3.*`, expanded to a hyphen range). **IPv4 only** — matching uses `ip2long()`, so IPv6
addresses never match a range and only pass via exact string equality. One entry per line in the
form.

## Global settings (`restrict_route_by_ip.settings`, `/…/restrict_route_by_ip/settings`)

- **status**: `enable` / `disable` (all rules off) / `disable_localhost` (rules off for
  `127.0.0.1` and `::1`, useful so local dev is never locked out). No `config/install` default
  ships, so an unconfigured site behaves as **enabled**.
- **debug_mode**: when on, denied IPs are logged to the `restrict_route_by_ip` logger channel.

## Trust model — read before relying on this

1. **The client IP must be trustworthy.** `getClientIp()` returns the direct TCP peer
   (`REMOTE_ADDR`) and only honours `X-Forwarded-For` when Drupal's `reverse_proxy` /
   `reverse_proxy_addresses` are configured in `settings.php`. This is the correct, non-spoofable
   default — but behind a CDN/load balancer with reverse-proxy settings *missing*, every request
   appears to come from the proxy and the allowlist is meaningless; and if a proxy is trusted but
   does not strip inbound `X-Forwarded-For`, clients can spoof it. Configure reverse proxy
   correctly.
2. **Route coverage is not capability coverage.** Restricting `user.login` does not restrict the
   same action reached through a REST/JSON:API route, a different form, or another route that lands
   in the same place. Enumerate every route that reaches the thing you are protecting.
3. **The web server / CDN is the stronger place for an IP allowlist** — enforced before PHP runs,
   unbypassable by an application bug. Use this module when the infrastructure is out of your
   control, when rules must travel with exported configuration, or must be editable without a
   deploy.

## Files / reference

- `agent/config/rules.md` — how to author a rule (route targets, IP formats, global modes, gotchas).
- Source of truth: `src/Service/RestrictIpService.php` (matching + IP check),
  `src/Routing/RouteSubscriber.php` (how restrictions are applied),
  `src/Access/ServicesAccessCheck.php`, `src/Entity/RestrictRouteByIp.php`,
  `src/Form/RestrictRouteForm.php`, `src/Form/RestrictRouteGlobalForm.php`.
