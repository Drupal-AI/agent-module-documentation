<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Filter (access_filter) — agent index

Request-level access control implemented as an **HTTP middleware** that runs before Drupal
routing. Each filter is a **configuration entity** (`access_filter`, config prefix `filter`)
combining *conditions* (which requests it applies to), *rules* (allow/deny by IP), and a
*response*. Version **2.1.0**; core `^9 || ^10 || ^11`. No dependencies, no composer.json, no
Drush commands.

## Where things live
- **Admin UI / configure:** `/admin/config/people/access_filter` (route
  `entity.access_filter.collection`), behind permission **`manage access filters`**.
- **Routes:** add / edit / delete forms under the same path, all requiring `manage access filters`.
- **Middleware:** service `access_filter.middleware` → `Drupal\access_filter\AccessFilterMiddleware`
  (D9-legacy variant `AccessFilterLegacyMiddleware`, swapped in by `AccessFilterServiceProvider`),
  tagged `http_middleware` at **priority 245**.
- **Entity:** `Drupal\access_filter\Entity\Filter` (`isAllowed()`, `parse()`).
- **Plugin managers:** `plugin.manager.access_filter.condition`, `plugin.manager.access_filter.rule`.
- **Config schema:** `access_filter.filter.*`. **Permission:** `manage access filters` only.

## Mechanism (read before answering "does my rule work?")
1. On every request, unless `$settings['access_filter_disabled']` is TRUE, the middleware loads all
   filters ordered by `weight` (ascending) and evaluates each **enabled** filter. The first filter
   that denies returns its response and short-circuits.
2. **Conditions are OR-combined.** The filter applies if *any* condition matches (`isMatched()` XOR
   its `negate` flag). **If no condition matches — including a filter with zero conditions — the
   filter does not apply and the request is allowed.** So conditions scope *which requests* the
   rules run against; a filter only restricts the paths/requests its conditions actually match.
3. **Rules default to allow.** All `ip` rules run in order; each returns allowed / forbidden /
   neutral, and the **last non-neutral result wins**. Build an allowlist as `deny *` followed by
   `allow <trusted>`; order matters.
4. **Response:** default code 403; 301/302 → redirect to `redirect_url`; otherwise a `Response` with
   the configured `body` and code (200/403/404/410/500/503).

## Condition & rule reference
- Conditions (`@AccessFilterCondition`): `path` (Drupal path via `path.matcher`), `uri` (path +
  query string), `session`, `cookie`, `env` (`$_SERVER`, e.g. HTTP_USER_AGENT / HTTP_REFERER),
  `and`, `or`. `path` / `uri` / key-value conditions accept `regex: 1`. Any condition negatable
  with `negate: 1`.
- Rules (`@AccessFilterRule`): `ip` only — `address` may be a single IP, CIDR (`192.168.0.0/24`),
  range (`192.168.0.1-192.168.0.10`), or `*`; `action: allow|deny`. Client IP obtained from
  `Request::getClientIp()`.
- Extend by dropping plugin classes under `Plugin/AccessFilter/Condition` or
  `Plugin/AccessFilter/Rule`. Full YAML examples: [config/filters.md](config/filters.md).

## Operational notes
- **Client IP behind a proxy/CDN/load balancer:** `getClientIp()` returns the connecting address
  unless Drupal's `reverse_proxy` / `reverse_proxy_addresses` settings are configured — configure
  them so IP rules match the real visitor rather than the proxy.
- **Lockout recovery:** if a filter denies your own access, set
  `$settings['access_filter_disabled'] = TRUE;` in `settings.php` to disable all filtering.
- For rules that must survive a Drupal that will not boot, or that need to run before PHP, the web
  server / CDN is a stronger enforcement point; use this module where rules must travel with site
  configuration or where infrastructure config is not available.

## Detail pages
- [config/filters.md](config/filters.md) — filter YAML structure, every condition/rule type with
  working examples, response options, weighting and evaluation order.
