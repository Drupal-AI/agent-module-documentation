# Configure Counter

## Admin surface

Landing route `counter.counter_settings` → `/admin/config/counter` renders a system menu
block (`SystemController::systemAdminMenuBlockPage`) linking these children. Every route
below requires the `administer counter` permission.

| route | path | handler | purpose |
|-------|------|---------|---------|
| `counter.basic` | `/admin/config/counter/basic` | `Form\CounterSettingsBasic` | toggle which values the block shows |
| `counter.advanced` | `/admin/config/counter/advanced` | `Form\CounterSettingsAdvanced` | recording behavior (skip admin, only pages, cron refresh) |
| `counter.initial` | `/admin/config/counter/initial` | `Form\CounterSettingsInitial` | seed offsets (starting counter / unique / since) |
| `counter.dashboard` | `/admin/config/counter/dashboard` | `Controller\CounterDashboard::page` | totals + top nodes/URLs report |
| `counter.statistics` | `/admin/config/counter/statistics` | `Controller\CounterStatistics::statisticsPage` | Chart.js time-series report |
| `counter.statistics.data` | `/admin/config/counter/statistics/data` | `Controller\CounterStatistics::statisticsData` | JSON feed for the chart |

Dashboard and statistics are covered in [../api/services.md](../api/services.md).

## Config object `counter.settings`

All keys are integers (0/1), schema `counter.settings` (`config/schema/counter.schema.yml`),
defaults in `config/install/counter.settings.yml`. Every "show" key defaults to `1` except
where noted.

**Basic form (`counter_basic`) — display toggles:**

| key | shows | default |
|-----|-------|---------|
| `counter_show_site_counter` | total rows in `counter` (+ initial offset) | 1 |
| `counter_show_unique_visitor` | distinct IP count (+ initial offset) | 1 |
| `counter_registered_user` | active users (uid>0, status=1, access>0) | 1 |
| `counter_unregistered_user` | users that never logged in (access=0) | 1 |
| `counter_blocked_user` | blocked users (status=0) | 1 |
| `counter_published_node` | published node count | 1 |
| `counter_unpublished_node` | unpublished node count | 1 |
| `counter_show_server_ip` | `SERVER_ADDR` | 1 |
| `counter_show_ip` | the viewer's own client IP | 1 |
| `counter_show_counter_since` | first `created` date (or initial-since override) | 1 |
| `counter_statistic_today` / `_week` / `_month` / `_year` | rolling view counts | 1 |

**Advanced form (`counter_advanced`) — recording behavior:**

| key | effect | default |
|-----|--------|---------|
| `counter_skip_admin` | don't count users with the `administrator` role | 0 |
| `counter_only_pages` | only count main-request `GET`s (skip sub-requests / non-GET) | 1 |
| `counter_refresh_on_cron` | (informational flag; cron always invalidates `counter_data_refresh`) | 1 |

**Initial form (`counter_initial`) — textfields, stored as-is:**

| key | meaning | default |
|-----|---------|---------|
| `counter_initial_counter` | number added to the site-counter total | 0 |
| `counter_initial_unique_visitor` | number added to the unique-visitor total | 0 |
| `counter_initial_since` | Unix timestamp that replaces the "since" date when non-zero | 0 |

The `counter_skip_admin` / `counter_only_pages` keys also gate the recording paths — see
[../events/recording.md](../events/recording.md).

## Set via drush / PHP

```bash
ddev drush config:set counter.settings counter_skip_admin 1 -y
ddev drush config:set counter.settings counter_initial_counter 10000 -y
```

```php
\Drupal::configFactory()->getEditable('counter.settings')
  ->set('counter_show_server_ip', 0)
  ->set('counter_only_pages', 1)
  ->save();
```

All three forms are `ConfigFormBase` subclasses editing only `counter.settings`; none add
custom validation (the `validateForm()` bodies are empty), so initial-value textfields are
saved without numeric validation.
