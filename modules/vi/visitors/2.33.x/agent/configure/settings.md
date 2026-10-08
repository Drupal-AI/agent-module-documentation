<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Settings form: *Configuration → System → Visitor Settings* (`/admin/config/system/visitors`,
route `visitors.settings`, permission `administer site configuration`). All values live in the
config object **`visitors.config`** (schema `visitors.config`).

## Config keys (`visitors.config`)

| Key | Default | Meaning |
|---|---|---|
| `flush_log_timer` | `0` | Log retention time (seconds; 0 = keep forever). Pruned on cron. |
| `bot_retention_log` | `0` | How long to keep bot logs. |
| `items_per_page` | `10` | Rows per report page. |
| `theme` | `admin` | Which theme the report pages render in. |
| `disable_tracking` | `false` | Master switch to stop all tracking. |
| `track.userid` | `true` | Also record the logged-in user id. |
| `counter.enabled` | `true`* | Enable the per-content hit counter. |
| `counter.entity_types` | `['node']` | Entity types that get a hit counter. |
| `counter.display_max_age` | `3600` | Cache lifetime (s) of a counter value. |
| `visibility.request_path_mode` | `0` | 0 = track all except listed paths, 1 = only listed. |
| `visibility.request_path_pages` | admin/* … | Paths for the mode above. |
| `visibility.user_role_mode` / `user_role_roles` | `0` / `{}` | Role-based tracking rules. |
| `visibility.user_account_mode` | `1` | Account-based tracking rule. |
| `visibility.exclude_user1` | `false` | Exclude the superuser from analytics. |
| `script_type` | `minified` | `minified` or full tracker script. |

\* the shipped install default is `true`; check the live value, it may differ.

```bash
drush config:get visitors.config
drush config:set visitors.config items_per_page 25 -y
```

## Rebuild forms (reprocess the existing log)

Because raw request data is logged, historic rows can be recomputed:

- `/admin/config/system/visitors/rebuild-route` (route `visitors.rebuild.route`)
- `/admin/config/system/visitors/rebuild-ip-address` (`visitors.rebuild.ip_address`)
- `/admin/config/system/visitors/rebuild-device` (`visitors.rebuild.device`)
- `/admin/config/system/visitors/performance` (legacy performance/statistics migrate)

The same work is available via Drush (see [../drush/commands.md](../drush/commands.md)).

## Reports

Under `/visitors` (menu parent `visitors.index`, permission `access visitors`): Recent hits,
Top pages, Hosts, Referrers, devices/browsers/OS, etc. — Views + Chart.js.
