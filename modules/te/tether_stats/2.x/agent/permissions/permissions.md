# Permissions and route gating

Two permissions (`tether_stats.permissions.yml`):

| Permission | Grants |
|---|---|
| `administer tether stats` | Manage stat-collection settings and all admin/report pages (settings, overview, element finder, activity purge, derivative CRUD, derivative autocomplete). Also the config-entity `admin_permission`. |
| `view tether stats chart data` | Fetch iterative chart data via `tether_stats.chart.data`. Grants access to **all data of any chart the user can load**; without it iterative charts do not work. |

## Route → permission map (`tether_stats.routing.yml`)

| Route | Path | Requirement |
|---|---|---|
| `tether_stats.settings_form` | `/admin/config/system/tether-stats` | `administer tether stats` |
| `tether_stats.overview` | `.../overview` | `administer tether stats` |
| `tether_stats.overview.element` | `.../overview/element` | `administer tether stats` |
| `tether_stats.element_finder_form` | `.../elements` | `administer tether stats` |
| `tether_stats.activity_purge_form` | `.../purge` | `administer tether stats` |
| `tether_stats.activity_purge_confirm_form` | `.../purge-before/{purge_before_date}` | `administer tether stats` (date `^\d\d\d\d-\d\d-\d\d$`) |
| `entity.tether_stats_derivative.collection` / `add_form` / `delete_form` / `enable` / `disable` | `.../derivatives…` | `administer tether stats` |
| `tether_stats.derivative.autocomplete` | `/tether_stats/autocomplete` | `administer tether stats` |
| `tether_stats.chart.data` | `/tether-stats/chart-data` | `view tether stats chart data` |
| `tether_stats.track` | `/tether-stats/track` | `access content` |

Notes:
- Every admin/report and derivative-management route is behind `administer tether stats`.
- `tether_stats.chart.data` reads only the **current user's** private-tempstore chart schema, so the
  permission exposes iteration of charts that user's own admin session created, not arbitrary data.
- `tether_stats.track` uses `access content` on purpose — it is the front-end tracking beacon that
  anonymous visitors must be able to reach so their page hits are recorded. Collection only happens
  when `tether_stats.settings:active` is on (off by default), and the `exclude_roles` setting can
  suppress tracking for chosen roles.
