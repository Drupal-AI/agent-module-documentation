<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Index API (google_index_api) — agent index

Notifies **Google's Indexing API** (`https://indexing.googleapis.com/v3/urlNotifications:publish`)
that a URL was updated (`URL_UPDATED`) or removed (`URL_DELETED`) so Google recrawls it promptly.
Authenticates with a Google service-account JSON key through the `google/apiclient ^2.0` library.
The module ships a service you call from your own entity hooks; it does not hook entities itself.

Core requirement `^10.2 || ^11`. Uses **State** (not config) for its two settings, and the core
**file** module (managed_file / File entity / file.usage) — required at runtime though not declared
in `info.yml`. Configure route: `google_index_api.settings_form`
(`/admin/config/services/google-index-api`). Defines one permission, no drush, no plugins, no
config schema.

- **Configure the credential + base domain** → [configure/settings.md](configure/settings.md)
- **Bulk-submit many URLs (post-migration backfill)** → [configure/bulk-update.md](configure/bulk-update.md)
- **Call the API from your entity update/delete hooks** → [api/service.md](api/service.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Service id `google_index_api.client` → class `Drupal\google_index_api\Service\GoogleIndexApi`;
  public methods `updateUrl($url)` and `deleteUrl($url)`; scope
  `https://www.googleapis.com/auth/indexing`.
- State keys: `google_index_api_json_file` (managed-file fid array) and
  `google_index_api_base_domain` (prepended to every submitted path).
- Routes: `google_index_api.settings_form` and
  `google_index_api.google_index_api_bulk_update_form`
  (`/admin/config/services/google-index-api/bulk-update`), both requiring
  `administer google index api`.
- Batch class `Drupal\google_index_api\Batch\GoogleIndexApiBatch` (`batchProcess`/`batchFinished`)
  backs the bulk form.
- Google scopes the Indexing API to job-posting and livestream pages; general pages are outside its
  documented use, and the quota is ~200 calls/project/day. Establish the use case qualifies before
  recommending it.
