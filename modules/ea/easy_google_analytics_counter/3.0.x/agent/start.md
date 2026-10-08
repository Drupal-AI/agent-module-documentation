<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Google Analytics Counter (easy_google_analytics_counter) — agent index

Pulls aggregated **page-view counts from Google Analytics (GA4 Data API)** on cron and writes them
into a **`page_views` integer base field on nodes** (`node_field_data`) for use in Views. Package
`Custom`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 3.0.1.

Composer requires **`google/analytics-data:^0.11.1`** (the GA4 Data API PHP client). No declared
Drupal module dependencies in `.info.yml`; at runtime relies on core `node`, `file` (managed_file
upload), `path_alias` and `views` (for the optional shipped view). No own permissions, no Drush.

## What it provides (from source)

- **Base field** `page_views` (integer, label *"Page views"*) added to the `node` entity type by
  `easy_google_analytics_counter_entity_base_field_info()` in `.module`.
- **Service** `easy_google_analytics_counter.connection` →
  `Drupal\easy_google_analytics_counter\ConnectionService` (implements `ConnectionServiceInterface`),
  constructed with `@service_container`. Its `request($page_path='')` runs the GA report and stores
  counts.
- **Config form** `AdminForm` (route `easy_google_analytics_counter.admin_form`,
  path `/admin/config/easy_google_analytics_counter/admin`, permission `administer site
  configuration`), writing config object `easy_google_analytics_counter.admin`.
- **Cron**: `easy_google_analytics_counter_cron()` calls `_easy_google_analytics_counter_independent_cron()`
  (which calls the service) unless `independent_cron` config is set (then you trigger it externally).
- **Two alter/invoke hooks** documented in `.api.php`.
- **Optional view** `views.view.popular_articles` (config/optional) → `/popular-articles`.

## Credential mechanism (verify — no env/Key recipe)

Authentication is a **Google service-account JSON key file**, supplied one of two ways in the admin
form and stored in the `easy_google_analytics_counter.admin` config object:
`service_account_credentials_json_path` (a filesystem **path string**) **or**
`service_account_credentials_json` (a **managed_file** upload). `ConnectionService::setKeyLocation()`
resolves whichever is set and exposes it to the Google client through
`putenv('GOOGLE_APPLICATION_CREDENTIALS=' . $path)`; `new BetaAnalyticsDataClient()` then reads it as
Application Default Credentials. There is **no** getenv/Key-entity/dotenv credential path in the code.

## Solution docs

- **Install, config object, every setting, routes, cron, the view** →
  [config/settings.md](config/settings.md)
- **The service, the GA report flow, the two hooks, the page_views field** →
  [api/service-and-hooks.md](api/service-and-hooks.md)
