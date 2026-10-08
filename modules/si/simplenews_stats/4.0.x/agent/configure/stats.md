# Stats UI, entity types, and storage

There is **no settings form**. The module's `configure` link points at the stats
collection list (`entity.simplenews_stats.collection`). Tracking activates simply by
enabling the module; nothing to configure. This doc covers where results appear and
how they are stored.

## Where results appear

| Route | Path | Access | What |
|---|---|---|---|
| `simplenews_stats.stats_tab` | `/node/{node}/simplenews-stats` | custom (see below) | Per-issue view: totals table, Chart.js line chart of clicks/views per day, "Top links" table |
| `entity.simplenews_stats.collection` | `/admin/content/simplenews-stats` | `access simplenews stats overview` | List of per-issue stat rows (Views / Clicks / Total sent) |
| `entity.simplenews_stats.canonical` | `/admin/content/simplenews-stats/{simplenews_stats}` | `simplenews_stats.view` entity access | Single stat entity view |
| `entity.simplenews_stats_item.collection` | `/admin/content/simplenews-stats-items` | `access simplenews stats overview` | Raw per-event rows (Created / Newsletter / User / Email / Action / Path) |

The per-node **Stats** tab (`simplenews_stats.links.task.yml`) shows on any node that
has a non-empty `simplenews_issue` field. Its access is decided by
`SimplenewsStatsAdminController::simplenewsStatsAccess()`:
- `access simplenews stats results` → allowed for any such node, or
- `access simplenews stats results editable node` → allowed only if the account also
  has core `update` access on that node.

The tab page (`SimplenewsStatsPage`) counts events by querying `simplenews_stats_item`
(entity query for totals; direct DB aggregation grouped by day for the chart and by
`route_path` for "Top links"). The chart uses library
`simplenews_stats/simplenews_stats.chartjs` (bundles a Chart.js 2.7.2 remote asset).

## Entity types

### `simplenews_stats` (per-issue totals)
- Base table `simplenews_stats`, id key `ssid`, `admin_permission = administer simplenews stats`.
- Handlers: storage `SimplenewsStatsEntityStorage`, list builder, view builder,
  access handler `SimplenewsStatsAccessControlHandler`, `views_data`, delete form.
- Base fields: `snid`, `entity_type`, `entity_id`, `clicks`, `views`,
  `total_emails`, `created`. Helpers: `increaseView/Click/TotalMail()`,
  `getViews/getClicks/getTotalMails()`, `getNewsletterEntity()`.
- Storage helpers: `getFromRelatedEntity($entity)`,
  `createFromSubscriberAndEntity($subscriber, $entity)`; `delete()` cascades to the
  related `simplenews_stats_item` rows.

### `simplenews_stats_item` (one row per event)
- Base table `simplenews_stats_item`, id key `ssiid`, label key `title`.
- Base fields: `title` (action: `click`/`view`), `uid` (author ref), `snid`,
  `email`, `entity_type`, `entity_id`, `route_path`, `created`.

### `simplenews_stats_allowedlinks` (plain table, `hook_schema`)
Columns `alid` (serial), `entity_type`, `entity_id`, `link` (text), indexed on
entity_type / entity_id / link. Holds the links harvested from each issue that the
click route is allowed to redirect to.

## Install / updates
`simplenews_stats.install` defines the `simplenews_stats_allowedlinks` schema and two
update hooks: `simplenews_stats_update_8101` (widens the stats `entity_type` field to
64 chars) and `simplenews_stats_update_8102` (installs the two optional Views if
Views is enabled). The Views ship in `config/optional/` (imported on install; no
config schema of the module's own).
