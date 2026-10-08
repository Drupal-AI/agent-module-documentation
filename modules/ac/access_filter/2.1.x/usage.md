<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Filter denies or allows incoming HTTP requests early in the request lifecycle using admin-defined filters that match request conditions and apply IP allow/deny rules.

---

The module registers an HTTP middleware (`access_filter.middleware`, class `Drupal\access_filter\AccessFilterMiddleware`, tagged `http_middleware` at priority 245, so it runs before routing, access checks and page cache). On every request — unless `$settings['access_filter_disabled']` is TRUE — it loads all `access_filter` configuration entities (`Drupal\access_filter\Entity\Filter`, config prefix `filter`), orders them by `weight` ascending, and evaluates each enabled filter in turn; the first filter that denies short-circuits and returns its configured response. A filter is stored as three YAML strings — `conditions`, `rules`, `response`. Evaluation (`Filter::isAllowed()`) is two-phase: first the **conditions** are OR-combined — the module iterates them and stops at the first whose `isMatched()` (XOR its `negate` flag) is true; if none matches (including a filter with zero conditions) the filter does not apply and the request is allowed. If a condition matched, the **rules** run in order with a default of allow: each `ip` rule returns allowed / forbidden / neutral and the last non-neutral result wins (so ordering matters and a later `allow` overrides an earlier `deny`). Condition plugins (annotation `@AccessFilterCondition`, manager `plugin.manager.access_filter.condition`) are `path` (Drupal path via `path.matcher`), `uri` (path + query string), `session`, `cookie`, `env` ($_SERVER values such as HTTP_USER_AGENT / HTTP_REFERER), and the chaining `and` / `or`; `path`, `uri` and the key/value conditions support a `regex: 1` mode. The only rule plugin is `ip` (annotation `@AccessFilterRule`, manager `plugin.manager.access_filter.rule`) supporting single IP, CIDR, `a-b` range, and `*`; the client IP comes from Symfony's `Request::getClientIp()`. On denial the parsed `response` (default code 403) yields a `RedirectResponse` for 301/302 or a plain `Response` with the configured body and code (200/403/404/410/500/503). Both plugin types are extensible by adding classes under `Plugin/AccessFilter/Condition` or `Plugin/AccessFilter/Rule`. Admin UI is at `/admin/config/people/access_filter` behind the `manage access filters` permission.

---

- Block a single abusive IP address from the entire site or a specific path.
- Block a CIDR subnet (e.g. `192.168.0.0/24`) of unwanted traffic.
- Block an inclusive IP range (e.g. `192.168.0.1-192.168.0.10`).
- Allowlist an office/VPN IP for an admin path while denying everyone else (order `deny *` then `allow <ip>`).
- Restrict `/admin` or `/user/login` to trusted IP addresses.
- Return a custom 403 body (maintenance/branded block page) to denied visitors.
- Redirect denied requests to another URL with a 301 or 302 response.
- Serve a 503 Service Unavailable to blocked traffic instead of 403.
- Gate a filter to a path prefix using a `path` condition (`{ type: path, path: /members }`).
- Match an exact URL including query string with a `uri` condition.
- Use a regular expression to match a family of paths (`{ type: path, path: '/\/admin\//i', regex: 1 }`).
- Apply a filter only when a specific cookie is present/absent (feature-flag or bypass token).
- Apply a filter only when a session value is set (e.g. logged-in-area gating).
- Match on a `$_SERVER` value such as HTTP_REFERER via the `env` condition.
- Combine several conditions with `and` so a filter applies only when all match.
- Combine conditions with `or` to cover multiple paths in one filter.
- Negate any condition with `negate: 1` (apply the filter everywhere *except* a path).
- Layer multiple filters by `weight` to build ordered allow/deny policies.
- Temporarily disable all filtering site-wide via `$settings['access_filter_disabled'] = TRUE` in `settings.php` (recovery escape hatch if you lock yourself out).
- Provide site-config-portable IP rules that travel with configuration export/import.
- Add a custom condition plugin (`@AccessFilterCondition`) for project-specific request matching.
- Add a custom rule plugin (`@AccessFilterRule`) to allow/deny on criteria other than IP.
- Draft and validate filters in the admin YAML editor, which reports per-line configuration errors.
