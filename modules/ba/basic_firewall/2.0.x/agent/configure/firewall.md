<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Basic Firewall

Admin base path: `/admin/config/system/basic-firewall` (permission `administer basic firewall`).

## Rule model
Rules are evaluated in three groups, in order: **allow** (first match ends evaluation), then **challenge**, then **block**. Within a group, lower weight runs first; rows are drag-reorderable on the Rules page (`basic_firewall.rules`).

Add a rule at `/admin/config/system/basic-firewall/rules/add` → pick a rule type plugin:
- `ip_address` — single IP or CIDR
- `user_agent` — UA substring/pattern
- `url` — request path pattern
- `asn` — autonomous system number
- `geo_location` — country (needs a GeoIP reader)
- `rate_limit` — requests per window per client
- `crs` / `vulnerability_score` — heuristic scoring
- `abuse_ipdb` — external reputation lookup

## Other tabs
- **Settings / Storage / Logging / Challenge** — global behaviour, blocked-client storage backend, logger channel `basic_firewall`, and the challenge flow.
- **Presets** (`/presets`) — import a shipped rule bundle; view one at `/presets/{preset}`.
- **Advanced** — edit the compiled config as YAML.
- **Test a request** (`/test`) — dry-run how a request would be classified.
- **Compiled** (`/compiled`) — inspect the compiled file the middleware reads.
- **Blocked** (`/blocked`) — list blocked clients; **Unblock** needs `unblock basic firewall clients`.

## Compiled cache
Rules live in config (`basic_firewall.settings`) and compile to a file in the private dir. The file is a rebuildable cache: it regenerates on config save and on `drupal_flush_all_caches()` (hook_rebuild). Force it with `drush bfw:rebuild`.

## Disable per environment
In settings.php: `$settings['basic_firewall_enabled'] = FALSE;` — the module never writes to settings.php itself.
