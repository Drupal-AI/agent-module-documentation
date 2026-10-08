<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics Counter (google_analytics_counter) — agent index

Fetches page-view counts from the **Google Analytics Data API (GA4)** on cron, stores them per path and
per node in Drupal, and exposes those counts as a **node field**, a **block**, a **filter token `[gac]`**,
and **Views** data. It does NOT add tracking JavaScript to your pages (that is the separate
`google_analytics` module's job); it only reads the resulting figures back from Google. Depends on core
`node`. Requires the Composer packages `google/analytics-data` and PHP `ext-bcmath`.

Config UI: `/admin/config/system/google-analytics-counter`
(`configure: google_analytics_counter.admin_settings_form`). All routes are gated by the single permission
`administer google analytics counter`. No Drush commands. Defines one plugin type
(`GoogleAnalyticsCounterResultProcessor`) and one event.

- **Settings form, config object, all `general_settings.*` keys, clear-table/queue, dashboard** →
  [configure/settings.md](configure/settings.md)
- **Authentication: GA4 property ID + service-account credentials.json** →
  [configure/settings.md](configure/settings.md)
- **The per-content-type counter field (add/remove `field_google_analytics_counter`)** →
  [configure/custom-field.md](configure/custom-field.md)
- **Services, cron→queue→storage→field data pipeline, public methods, DB tables** →
  [api/services.md](api/services.md)
- **Result-processor plugin type (map GA rows→nodes) + how to add one** →
  [plugins/result-processors.md](plugins/result-processors.md)
- **Altering the GA4 query before it runs** → [events/query-alter.md](events/query-alter.md)
- **Block + `[gac]` token + theme hook/template** → [blocks/counter-block.md](blocks/counter-block.md)
- **Views integration** → [views/integration.md](views/integration.md)

Key facts:
- Config object `google_analytics_counter.settings`, everything nested under `general_settings.*`
  (e.g. `general_settings.ga4_property_id`, `general_settings.credentials_json_path`,
  `general_settings.cron_interval`, `general_settings.result_processor`).
- Permission: `administer google analytics counter`.
- Services: `google_analytics_counter.app_manager`, `google_analytics_counter.cron`,
  `google_analytics_counter.custom_field_generator`, `google_analytics_counter.message_manager`,
  `plugin.manager.google_analytics_counter_result_processor`, `logger.channel.google_analytics_counter`.
- Routes (all `_permission: administer google analytics counter`):

  | Route | Path |
  |---|---|
  | `google_analytics_counter.admin_settings_form` | `/admin/config/system/google-analytics-counter` |
  | `google_analytics_counter.admin_auth_form` | `…/google-analytics-counter/authentication` |
  | `google_analytics_counter.admin_dashboard_form` | `…/google-analytics-counter/dashboard` |
  | `google_analytics_counter.configure_types_form` | `…/google-analytics-counter-configure-types` |
  | `google_analytics_counter.confirm_clear_queue` | `…/google-analytics-counter/clear-queue` |
  | `google_analytics_counter.confirm_clear_page_path_delete` | `…/google-analytics-counter/clear-page-path-table` |

- DB tables (`hook_schema`): `google_analytics_counter` (`pagepath_hash` PK, `pagepath`, `pageviews`) and
  `google_analytics_counter_storage` (`nid` PK, `pageview_total`); also writes the field table
  `node__field_google_analytics_counter`.
- Queue worker `google_analytics_counter_worker`; cache tag `google_analytics_counter_data`.
- Data is a periodic cron snapshot: counts lag reality by the cron/queue interval — not a live counter.

```bash
drush cget google_analytics_counter.settings
drush cron    # fetching + node mapping happen here (throttled by cron_interval)
```
