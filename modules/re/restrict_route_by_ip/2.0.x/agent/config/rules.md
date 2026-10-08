<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authoring restriction rules

All configuration is UI-driven at `/admin/config/system/restrict_route_by_ip` (permission
`admin restrict route by ip`). There are no Drush commands. Rules are `restrict_route` config
entities (`config_prefix: restrict_route`, schema `restrict_route_by_ip.restrict_route.*`), so they
export/import like any config and can be written directly in YAML.

## Rule entity fields

A `restrict_route.<id>.yml` exports these keys (`config_export` in
`src/Entity/RestrictRouteByIp.php`):

| key         | meaning                                                                    |
|-------------|----------------------------------------------------------------------------|
| `id`        | machine name                                                               |
| `label`     | admin label                                                                |
| `route`     | the target (see the four syntaxes below) — a single string                 |
| `ips`       | array of IPs/ranges, one per line in the form (required in the UI)         |
| `methods`   | array of HTTP methods the rule applies to (`GET`/`POST`/`DELETE`/`PATCH`)   |
| `params`    | array of `key=value` query-parameter conditions (optional)                 |
| `operation` | `false` = *Restrict access* (blocklist); `true` = *Allow access* (allowlist) |
| `status`    | `true` = enabled (entity key `status` maps to `enabled`)                    |

## Operation mode — allowlist vs blocklist

Set by the **Operation** radios on the add/edit form. The semantics come from
`RestrictIpService::userIpIsRestricted()`:

- **Allow access** (`operation: true`) → **allowlist**: only IPs that match `ips` may reach the
  route; everyone else gets 403. Use this to lock a route to known networks (office, VPN, partner).
- **Restrict access** (`operation: false`, the form's **default**) → **blocklist**: IPs that match
  `ips` are denied; everyone else is allowed through. Use this to keep specific addresses out of an
  otherwise-public route.

These are near-opposites, so set the mode to match your intent. If you want "only my office can
reach `/admin`", that is **Allow access** — the default (Restrict access) would instead block the
office and leave the route open to everyone else.

## Methods and params — when the rule engages

A rule only takes effect for a request when `RestrictIpService::requestAffected()` is satisfied:

- **methods** (required, at least one): the request's HTTP method must be one of the selected
  `GET`/`POST`/`DELETE`/`PATCH`. A request using any other method on a restricted route is denied
  (fail-closed). An entity with an empty `methods` array matches no request and denies everything.
- **params** (optional): one `key=value` per line. All configured values must be present in the
  request's query string for the rule to engage.

## The `route` target — four syntaxes

Resolved by `RestrictIpService::getAllRouteNamesAndPath()`:

1. **Route name** — exact machine name, e.g. `user.login`, `system.admin`. Matches that one route.
2. **Path** — any value containing `/`, e.g. `/user/login`. Compiled to an **unanchored** regex
   `#/user/login#` and tested against every registered route's path (route placeholders such as
   `{node}` are replaced with a literal token first). Unanchored = matches any route whose path
   *contains* the substring. Prefer route names when you want exactly one route.
3. **`%` wildcard path** — e.g. `/admin/%/content`; `%` becomes `.+`.
4. **Regex** — a string starting and ending with `#`, e.g. `#^/admin/.*#`, applied to route paths.

A rule expands to a set of route **names**, so aliases pointing at the same route are covered, but a
*different* route reaching the same functionality is **not**. Use the form's live "Impacted routes"
preview (AJAX) to confirm coverage before enabling.

## IP / range formats (`checkRangeIp()`)

One entry per line. **IPv4 only** (matching uses `ip2long()`):

- Single address — `203.0.113.7`
- CIDR — `203.0.113.0/24`
- Hyphen range — `203.0.113.10-203.0.113.20`
- `*` wildcard — `203.0.113.*` (expanded internally to a hyphen range)

An IPv6 address only matches by exact string equality — ranges do not apply to it.

## Global settings (`restrict_route_by_ip.settings`)

At `/admin/config/system/restrict_route_by_ip/settings`:

- `status`: `enable` | `disable` (all rules ignored) | `disable_localhost` (`127.0.0.1` / `::1` are
  treated as matching any rule's IP list). No `config/install` default ships, so an unconfigured
  site behaves as if **enabled**.
- `debug_mode`: log every denied IP to the `restrict_route_by_ip` logger channel.

## Gotchas

- Saving a rule, enabling/disabling it, or changing global settings rebuilds the router
  (`router.builder->rebuild()`); restricted routes are marked `no_cache`.
- The `ips` field is **required** in the form, and `methods` must have at least one value. A rule
  whose `methods` ends up empty (e.g. via a hand-edited config import) denies every request to the
  route.
- `disable_localhost` only ever makes loopback addresses *match* a rule's list; on an **allowlist**
  that allows local dev through, but on a **blocklist** it would mark loopback as blocked. Loopback
  is not routable from outside, so this is a local-dev convenience, not an external control.
- Behind a proxy/CDN, set `reverse_proxy` and `reverse_proxy_addresses` in `settings.php` or the IP
  the module sees is the proxy's, not the visitor's.
- No update hook ships: review and re-save every rule after upgrading from 1.x (the new `operation`
  defaults to blocklist and `methods` starts empty).
