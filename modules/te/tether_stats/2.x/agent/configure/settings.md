# Configure (settings, filters, derivatives)

All configuration lives in the config object **`tether_stats.settings`** (schema
`config/schema/tether_stats.schema.yml`), edited by the settings form
`\Drupal\tether_stats\Form\TetherStatsSettingsForm` at route **`tether_stats.settings_form`**
(`/admin/config/system/tether-stats`, permission `administer tether stats`). Collection is **off by
default**. Tabs on that page: Settings, Overview, Element Finder, Derivatives, Activity Purge.

## `tether_stats.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `active` | bool | `false` | Master switch. When false, the request subscriber, `hook_page_attachments`, the track controller and overview pages all short-circuit (`TetherStatsManager::isActive()`). |
| `allow_query_string_elements` | bool | `false` | If true, a page's query string contributes to element uniqueness — each distinct query string becomes a separate element (adds an extra "Query String" column to the overview table). |
| `filter.mode` | string | `exclude` | `exclude` = track everything **except** matches; `include` = track **only** matches (include mode allows all when no rules are set). |
| `filter.rules.url` | sequence(string) | `['admin']` | URL path rules (see matching below). |
| `filter.rules.route` | sequence(string) | `['quickedit.*','history.*','contextual.render','entity.node.preview','tether_stats.chart.data']` | Route-name rules. |
| `exclude_roles` | sequence(string) | `['administrator']` | Users with any of these roles never generate stats (checked in `TetherStatsRequestSubscriber::isFiltered`). |
| `database` | string | `default` | Target DB connection key. If not `default`, all stat tables live on that connection (must be registered in `settings.php`); the schema is installed on submit. |
| `chart_plugin` | string | `tether_stats_google_charts` | Active `TetherStatsChartRenderer` plugin id. |
| `advanced.element_ttl` | int (sec) | `432000` (5 days) | How long an element row may persist before its identity fields are refreshed on next hit (handles URL/entity edits). Validated as a positive integer. |
| `advanced.first_activation_time` | int (unixtime) | `0` | Lower bound for chart iteration; set automatically to `REQUEST_TIME` the first time `active` is switched on. Validated as a non-negative integer. |

## Page-tracking filter (how rules match)

Filtering is done by `\Drupal\tether_stats\TetherStatsRequestFilter` before an element is created for
a request. Two rule kinds, combined with `filter.mode`:

- **Route rules** (`filter.rules.route`) — matched against the current route name, split on `.`.
  `*` is a single-part wildcard; a trailing `*` matches all deeper parts. Examples:
  `entity.node.canonical` (exact), `entity.*.canonical` (any entity view), `tether_stats.*` (all this
  module's routes). The route `tether_stats.track` is **always** filtered (hard-coded in
  `isRouteFiltered`).
- **URL rules** (`filter.rules.url`) — matched against the request path, split on `/`. `%` matches any
  one part; `#` matches a numeric part; a matching rule also matches any deeper URL. Examples:
  `admin` (everything under `/admin`), `node/#/edit` (all node edit pages), `%/track`.

Precedence (`isFiltered`): in **exclude** mode a request is tracked unless a route rule matches (or,
if no route rule matches, unless a URL rule matches); in **include** mode it is tracked only when a
route or URL rule matches. Then, regardless of mode, a user in any `exclude_roles` role is filtered
out.

## Derivatives (config entity `tether_stats_derivative`)

Derivatives create additional, independent counters that relate to a base element. Managed at
`entity.tether_stats_derivative.collection` (`/admin/config/system/tether-stats/derivatives`), forms
`add`/`delete`/`enable`/`disable` (`admin_permission = administer tether stats`). Config keys:

| Key | Meaning |
|---|---|
| `name` | Machine id of the derivative (entity id). |
| `status` | Enabled flag. A disabled derivative fails identity-set validation (unless ignored). |
| `description` | Human description. |
| `derivativeEntityType` | Constrain the derivative to one entity type (`*` / empty = any). |
| `derivativeBundle` | Constrain to one bundle (`*` / empty = any); enforced by loading the entity. |

A derivative may **not be deleted** while elements reference it — `TetherStatsDerivative::access()`
denies `delete` when `getUsageCount() > 0`. Scope string is `entityType:bundle`
(`getDerivativeScope()`).

## Activity purge

`tether_stats.activity_purge_form` (`.../purge`) → confirm route
`tether_stats.activity_purge_confirm_form` (`.../purge-before/{purge_before_date}`, where
`purge_before_date` must match `^\d\d\d\d-\d\d-\d\d$`). Both require `administer tether stats`. Purges
old rows from the activity/impression tables before the chosen date.

## Set config from code

```php
\Drupal::configFactory()->getEditable('tether_stats.settings')
  ->set('active', TRUE)
  ->set('allow_query_string_elements', FALSE)
  ->set('filter.mode', 'exclude')
  ->set('filter.rules.url', ['admin'])
  ->set('exclude_roles', ['administrator'])
  ->set('advanced.element_ttl', 432000)
  ->save();
```
