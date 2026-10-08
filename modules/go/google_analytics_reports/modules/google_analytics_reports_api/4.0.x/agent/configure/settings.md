<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Google Analytics Reports API

## Settings form

Route `google_analytics_reports_api.settings` → `/admin/config/services/google-analytics-reports-api`
(form id `google_analytics_reports_api_settings`). Permission: `administer google analytics reports api`.

| Field | Config key | Notes |
|---|---|---|
| Property ID | `property` | GA4 numeric property id (required) |
| Credential JSON | `json` | `managed_file`, uploaded to `private://`, stored as a file id; set permanent on save |
| Query cache | `cache_length` | select of 1-6 days / 1-4 weeks, in seconds; default `259200` (3 days). Only shown once the account authenticates. |

Config object `google_analytics_reports_api.settings` (this module's `getEditableConfigNames()`).
The shipped install file also seeds legacy keys `client_id`, `client_secret`, `default_page`,
`profile_id` — remnants of the pre-GA4 (Universal Analytics) version, not used by the GA4 code.

Read/set from drush:

```bash
drush cget google_analytics_reports_api.settings cache_length   # e.g. 259200
drush cget google_analytics_reports_api.settings property
drush cset google_analytics_reports_api.settings cache_length 604800 -y   # 7 days
```

## Getting credentials (Google Cloud)

1. In Google Cloud Console enable the **Google Analytics Data API** for a project.
2. API & Services » Credentials » Create credentials » **Service account**.
3. In the service account, create a **key** in **JSON** format and download it.
4. In Google Analytics, add the service account's email as a **Viewer** on the GA4 property.
5. On the Drupal form, enter the **Property ID** and upload the **JSON** key, then save.

The form **validates** on save: it builds a feed from the uploaded key
(`GoogleAnalyticsReportsApiFeed::service()`) and rejects the credential if it does not
authenticate (`isAuthenticated()` false). Private-file support must be configured for the
upload to work.

## What it does not provide

No plugins, Views handlers, report pages or blocks — those live in the parent
`google_analytics_reports` module. This submodule only stores credentials/settings and exposes
the feed service (see [../api/feed-service.md](../api/feed-service.md)).
