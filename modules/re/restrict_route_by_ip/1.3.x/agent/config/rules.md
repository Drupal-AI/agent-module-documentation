<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authoring restriction rules

All configuration is UI-driven at `/admin/config/system/restrict_route_by_ip` (permission
`admin restrict route by ip`). There are no Drush commands. Rules are `restrict_route` config
entities (`config_prefix: restrict_route`, schema `restrict_route_by_ip.restrict_route.*`), so they
export/import like any config and can be written directly in YAML.

## Rule entity fields

A `restrict_route.<id>.yml` exports these keys (`config_export` in
`src/Entity/RestrictRouteByIp.php`):

| key      | meaning                                                        |
|----------|---------------------------------------------------------------|
| `id`     | machine name                                                  |
| `label`  | admin label                                                   |
| `route`  | the target (see the four syntaxes below) — a single string    |
| `ips`    | array of allowed IPs/ranges, one per line in the form         |
| `status` | `true` = enabled (entity key `status` maps to `enabled`)      |

## The `route` target — four syntaxes

Resolved by `RestrictIpService::getAllRouteNamesAndPath()`:

1. **Route name** — exact machine name, e.g. `user.login`, `system.admin`. Matches that one route.
2. **Path** — any value containing `/`, e.g. `/user/login`. Compiled to an **unanchored** regex
   `#/user/login#` and tested against every registered route's path (route placeholders such as
   `{node}` are replaced with a literal token first). Unanchored = matches any route whose path
   *contains* the substring. Prefer route names when you want exactly one route.
3. **`%` wildcard path** — e.g. `/admin/%/content`; `%` becomes `.+`.
4. **Regex** — a string starting and ending with `#`, e.g. `#^/admin/.*#`, applied to route paths.

Because a rule expands to a set of route **names**, aliases pointing at the same route are covered,
but a *different* route reaching the same functionality is **not**. Use the form's live "Impacted
routes" preview (AJAX) to confirm coverage before enabling.

## IP / range formats (`checkRangeIp()`)

One entry per line. **IPv4 only** (matching uses `ip2long()`):

- Single address — `203.0.113.7`
- CIDR — `203.0.113.0/24`
- Hyphen range — `203.0.113.10-203.0.113.20`
- `*` wildcard — `203.0.113.*` (expanded internally to a hyphen range)

An IPv6 address only matches by exact string equality — ranges do not apply to it.

## Global settings (`restrict_route_by_ip.settings`)

At `/admin/config/system/restrict_route_by_ip/settings`:

- `status`: `enable` | `disable` (all rules ignored) | `disable_localhost` (rules ignored for
  `127.0.0.1` / `::1`). No `config/install` default ships, so an unconfigured site behaves as if
  **enabled**.
- `debug_mode`: log every denied IP to the `restrict_route_by_ip` logger channel.

## Gotchas

- Saving a rule or changing global settings rebuilds the router (`router.builder->rebuild()`);
  restricted routes are marked `no_cache`.
- The `ips` field is **required** in the form. A rule whose `ips` ends up empty (e.g. via a
  hand-edited config import) **allows everyone** — the restriction silently does nothing. Always
  ship a non-empty list.
- Behind a proxy/CDN, set `reverse_proxy` and `reverse_proxy_addresses` in `settings.php` or the
  IP the module sees is the proxy's, not the visitor's.
- Use `disable_localhost` (or include your own IP) so you cannot lock yourself out while testing.
