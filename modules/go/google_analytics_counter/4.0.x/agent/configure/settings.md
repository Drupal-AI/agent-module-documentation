# Configure Google Analytics Counter

Two admin forms hold configuration, both writing the single config object `google_analytics_counter.settings`
(all keys nested under `general_settings`). Both require the `administer google analytics counter` permission.

## Authentication (GA4) — `google_analytics_counter.admin_auth_form`

Path `/admin/config/system/google-analytics-counter/authentication`
(`GoogleAnalyticsCounterAuthForm`). This is GA4 / service-account based — there is **no OAuth
authorization-code round-trip and no callback route**. Two fields:

| Field | Config key | Notes |
|---|---|---|
| Google Analytics 4 Property ID | `general_settings.ga4_property_id` | The GA4 property to query (used as `properties/{id}`). |
| Path to the service account credentials.json | `general_settings.credentials_json_path` | Relative or absolute filesystem path to the Google service-account JSON. `GoogleAnalyticsCounterAppManager::gacGetFeed()` does `putenv('GOOGLE_APPLICATION_CREDENTIALS=' . $path)`, then `new BetaAnalyticsDataClient()` reads it. |

Enable the Google Analytics Data API and add the service account as a viewer on the GA4 property first
(the form links to Google's quickstart).

## Settings — `google_analytics_counter.admin_settings_form`

Path `/admin/config/system/google-analytics-counter` (`GoogleAnalyticsCounterSettingsForm`). This is the
`configure` route. Fields:

| Field | Config key | Default | Notes |
|---|---|---|---|
| Minimum time between fetches (minutes) | `general_settings.cron_interval` | 30 | `0` = fetch on every cron. |
| Items to fetch per request | `general_settings.chunk_to_fetch` | 1000 | Page size for GA queries; changing it truncates the `google_analytics_counter` table. |
| Query cache (hours) | `general_settings.cache_length` | 86400 (stored in **seconds**; form shows hours) | Reuse cached GA results for the same query. |
| Queue Time (seconds) | `general_settings.queue_time` | 120 | How long the worker runs per cron; changing it flushes all caches. |
| Update pageviews for content created in the last X days | `general_settings.node_last_x_days` | (empty) | Throttle which nodes get processed. |
| Update pageviews for content not newer than X days | `general_settings.node_not_newer_than_x_days` | (empty) | Skip too-recent nodes (GA4 data lags up to 24h). |
| Update pageviews for the last X content | `general_settings.node_last_x_nid` | (empty) | Cap node processing per run. |
| Metric | `general_settings.metric` | `screenPageViews` | Single GA4 metric name. |
| Dimension | `general_settings.dimension` | `pagePath` | Single GA4 dimension name. |
| Result processor | `general_settings.result_processor` | `url_alias` | Which plugin maps GA rows→nodes. See [plugins/result-processors.md](../plugins/result-processors.md). |
| Date range | `general_settings.start_date` (+ derived `general_settings.end_date`) | `30 days ago` | Preset or `custom` / `custom_day`. |
| Custom start/end date | `general_settings.custom_start_date` / `custom_end_date` | (empty) | `Y-m-d`, used when range = `custom`. |
| Custom start/end day | `general_settings.custom_start_day` / `custom_end_day` | (empty) | Integer day offsets, used when range = `custom_day`. |

`submitForm()` derives `end_date` from the chosen `start_date` preset (`setEndDate()`), stores
`cache_length` as hours × 3600, and invalidates cache tag `google_analytics_counter_data`. The date settings
are resolved at query time by `GoogleAnalyticsCounterHelper::buildQueryDates()`.

The form also has two danger buttons (modal confirm forms):

- **Clear queue** → `google_analytics_counter.confirm_clear_queue` (`ConfirmClearQueueForm`) — deletes the
  `google_analytics_counter_worker` queue.
- **Clear pagepath - pageview table** → `google_analytics_counter.confirm_clear_page_path_delete`
  (`ConfirmClearPagePathTableForm`) — truncates `google_analytics_counter`, resets state
  `google_analytics_counter.total_paths`, and deletes the queue.

### Legacy / unused keys

`config/install` also seeds `client_id`, `client_secret`, `redirect_uri`, `project_name`, `profile_id`.
These are leftovers from the pre-GA4 (Universal Analytics/OAuth) branch and are **not read or written** by
the 4.0.x forms or the app manager.

## Dashboard — `google_analytics_counter.admin_dashboard_form`

Path `…/dashboard` (`GoogleAnalyticsCounterController::dashboard`). Read-only report: total pageviews/paths
(from state), local counts (`GoogleAnalyticsCounterHelper::getCount()`), top-twenty tables
(`GoogleAnalyticsCounterMessageManager::getTopTwentyResults()`), last cron run, and a "run cron now" link.
It does not itself call Google; the numbers are refreshed on cron.

## Set via Drush / PHP

```bash
drush cset google_analytics_counter.settings general_settings.ga4_property_id '123456789'
drush cset google_analytics_counter.settings general_settings.credentials_json_path '../credentials.json'
drush cset google_analytics_counter.settings general_settings.cron_interval 30
drush cset google_analytics_counter.settings general_settings.result_processor url_alias
```

```php
\Drupal::configFactory()->getEditable('google_analytics_counter.settings')
  ->set('general_settings.ga4_property_id', '123456789')
  ->set('general_settings.credentials_json_path', '../credentials.json')
  ->set('general_settings.metric', 'screenPageViews')
  ->set('general_settings.dimension', 'pagePath')
  ->save();
```

## Config schema

`config/schema/google_analytics_counter.schema.yml` declares `google_analytics_counter.settings` as a
`config_object` with the `general_settings` mapping listing every key above (plus per-bundle
`gac_type_{content_type}` and `gac_type_page`). There is no per-entity third-party settings; everything
lives in this one object.
