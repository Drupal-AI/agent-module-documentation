<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict route by IP (restrict_route_by_ip) — agent index

Gates Drupal routes by client IP. Rules are `restrict_route` **configuration entities** managed at
`/admin/config/system/restrict_route_by_ip`, gated by the `admin restrict route by ip` permission
(`restrict access: true`). Installed version **2.0.0**, core `^10 || ^11`, package Administration.
No module dependencies, no Drush commands.

## What it actually does

- Each **`restrict_route` config entity** holds: `label`, machine `id`, a single `route` target, a
  list of `ips`, a set of `methods`, optional `params`, an `operation` mode, and an enabled
  `status`.
- On every route rebuild, `RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`)
  resolves each enabled entity's `route` target to concrete route names and, for each, sets
  `_custom_access` → `restrict_route_by_ip.services_access_checker::access` and the `no_cache`
  route option.
- `ServicesAccessCheck::access()` (`src/Access/ServicesAccessCheck.php`) returns
  `AccessResult::allowedIf($svc->requestAffected() && !$svc->userIpIsRestricted($account))`.
  Because `allowedIf(FALSE)` is **neutral** (not forbidden) and Drupal requires *all* of a route's
  access checks to be allowed, the restricted route is reachable **only** when this check returns
  ALLOWED — otherwise the original route access AND a neutral custom check combine to a 403. The
  gate can only *narrow* access, never widen it. This is fail-closed.

## The two things that decide a rule's meaning (new/reworked in 2.0.x)

- **`operation` (Operation mode).** The add/edit form offers radios *Restrict access* (stored
  `operation = FALSE`, the form's **default**) and *Allow access* (`operation = TRUE`).
  `userIpIsRestricted()` logic (`src/Service/RestrictIpService.php`):
  - If the client IP matches **any** entry in `ips`: `restricted = !operation`.
  - If it matches none: `restricted = operation`.
  So **Allow access = allowlist** (only listed IPs may reach the route; all others 403) and
  **Restrict access = blocklist** (listed IPs are denied; everyone else is allowed through). Choose
  deliberately — the two modes are near-opposites, and the form's default is the blocklist.
- **`requestAffected()`** (`src/Service/RestrictIpService.php`) gates whether the restriction
  engages at all: it returns FALSE (→ custom access neutral → 403 on a restricted route) unless the
  request's **method** is one of the entity's `methods` AND all configured `params` values are
  present in the query string. `methods` is required in the form; an entity with an empty `methods`
  array matches no method, so the route denies every request.

## Client IP and enforcement path

- Client IP comes from **`Request::getClientIp()`** (`src/Service/RestrictIpService.php`,
  `userIpIsRestricted()`) — the direct TCP peer (`REMOTE_ADDR`); `X-Forwarded-For` is honoured only
  when Drupal's `reverse_proxy`/`reverse_proxy_addresses` are set in `settings.php`. This is the
  correct, non-spoofable default.
- The enabled-rule query in `getAllRestrictedRoutes()` uses `->accessCheck()` on a **config**
  entity query; verified empirically that it still returns rules for an **anonymous** user, so the
  restriction is enforced for anonymous requests (login/admin pages work as intended).

## The `route` target — four syntaxes (`getAllRouteNamesAndPath()`)

1. **Route name** — exact, e.g. `user.login`. Matches only that one route.
2. **Path** — contains `/`, e.g. `/user/login`. Converted to an **unanchored** regex `#/user/login#`
   and matched against every registered route's path (placeholders replaced with a literal token).
   Unanchored means it matches any route whose path *contains* the string — it over-matches, never
   under-matches.
3. **Path with `%` wildcard** — e.g. `/admin/%/content` → `%` becomes `.+`.
4. **Regex** — a string wrapped in `#…#`, applied directly to route paths.

The add/edit form previews the resolved route **paths** live (AJAX POST to
`restrict_route_by_ip.impacted_path`, which also requires the admin permission).

## IP / range formats (`checkRangeIp()`)

Single IP (`1.2.3.4`), CIDR (`1.2.3.0/24`), hyphen range (`1.2.3.0-1.2.3.255`), and `*` wildcard
(`1.2.3.*`, expanded to a hyphen range). **IPv4 only** — matching uses `ip2long()`, so an IPv6
address never matches a range and only passes via exact string equality. One entry per line.

## Global settings (`restrict_route_by_ip.settings`, `/…/restrict_route_by_ip/settings`)

- **status**: `enable` / `disable` (all rules off) / `disable_localhost` (treats `127.0.0.1` and
  `::1` as matching any rule's IP list — intended so local dev is not locked out of an allowlist
  rule). No `config/install` default ships, so an unconfigured site behaves as **enabled**.
- **debug_mode**: when on, denied IPs are logged to the `restrict_route_by_ip` logger channel.

## Upgrading from 1.x

There is **no `.install` / update hook**. 1.x rules (which were always allowlists) load with the new
`operation` defaulting to `FALSE` and empty `methods`/`params`; with empty `methods` a restricted
route denies every request until you re-save each rule choosing *Allow access* and the methods it
should cover. Review every rule after upgrading.

## Trust model — read before relying on this

1. **The client IP must be trustworthy.** Behind a CDN/load balancer with reverse-proxy settings
   *missing*, every request appears to come from the proxy and the list is meaningless; if a proxy
   is trusted but does not strip inbound `X-Forwarded-For`, clients can spoof it. Configure reverse
   proxy correctly.
2. **Route coverage is not capability coverage.** Restricting `user.login` does not restrict the
   same action via a REST/JSON:API route, a different form, or another route that reaches the same
   place. Enumerate every route that reaches what you protect.
3. **The web server / CDN is the stronger place for an IP list** — enforced before PHP runs,
   unbypassable by an application bug. Use this module when the infrastructure is out of your
   control, when rules must travel with exported configuration, or must be editable without a
   deploy.

## Files / reference

- `agent/config/rules.md` — how to author a rule (route targets, IP formats, modes, methods/params,
  global settings, gotchas).
- Source of truth: `src/Service/RestrictIpService.php` (matching, IP check, `requestAffected`),
  `src/Routing/RouteSubscriber.php` (how restrictions are applied),
  `src/Access/ServicesAccessCheck.php`, `src/Entity/RestrictRouteByIp.php`,
  `src/Form/RestrictRouteForm.php`, `src/Form/RestrictRouteGlobalForm.php`,
  `src/Controller/StatusController.php`.
