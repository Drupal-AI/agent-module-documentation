<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Saved Searches (search_api_saved_searches) — agent index

Lets visitors save a Search API search and be notified (by email) when new matching
results appear. A search is stored as the `search_api_saved_search` content entity; how
it behaves (notification method, schedule, "new result" detection) is governed by the
`search_api_saved_search_type` config/bundle entity. New results are found on cron by
re-running each saved query and delivered through pluggable **notification** plugins
(the built-in one is `email`).

Depends on `search_api (>= 8.x-1.20)`, core `options`, core `user`. Core: `^10.1 || ^11`.
Configure route: `entity.search_api_saved_search_type.collection`
(`/admin/config/search/search-api-saved-searches`). Defines permissions, a Drush command,
a block, a notification plugin type, config schema, and Token integration.

- **Create/configure a saved-search type (notification method, schedule, new-result detection, displays)** → [configure/type.md](configure/type.md)
- **Place the "Save search" block + the site-wide cron batch setting** → [configure/block-and-settings.md](configure/block-and-settings.md)
- **Add a custom delivery method (notification plugin type)** → [api/notification-plugins.md](api/notification-plugins.md)
- **Services, entities, access token, hooks & tokens** → [api/services-and-hooks.md](api/services-and-hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **The `check-all` Drush command** → [drush/commands.md](drush/commands.md)

Key facts:
- Content entity `search_api_saved_search` (base/data table `search_api_saved_search`); bundle
  config entity `search_api_saved_search_type` (config prefix `search_api_saved_searches.type.*`).
  A `default` type is installed automatically.
- Settings object `search_api_saved_searches.settings`, one key: `cron_batch_size` (default `10`,
  `0` = no limit) — max saved searches checked per cron run.
- Services: `search_api_saved_searches.new_results_check` (finds/reports new results),
  `search_api_saved_searches.email_queue` (sends queued mails on request destruction),
  `plugin.manager.search_api_saved_searches.notification`, `logger.channel.search_api_saved_searches`.
- Notification plugin type `search_api_saved_searches_notification`: attribute
  `SearchApiSavedSearchesNotification`, base `NotificationPluginBase`, directory
  `Plugin/search_api_saved_searches/notification`, built-in plugin id `email`.
- `hook_cron()` → `NewResultsCheck::checkAll()`. Extra DB table
  `search_api_saved_searches_old_results` tracks already-seen result item IDs.
- Routes on the search entity: `entity.search_api_saved_search.canonical` / `.activate` /
  `.edit_form` / `.delete_form`; each gated by `_entity_access` on the matching operation.
- Permissions: `administer search_api_saved_searches` plus a generated
  `use <type_id> search_api_saved_searches` per type (`Permissions::bySavedSearchType()`).
- Block plugin id `search_api_saved_searches` (admin label "Save search", category "Forms").
- Optional Views `saved_searches` (route `view.saved_searches.page`) and `saved_searches_admin`.
- Token types: `search-api-saved-search`, `search-api-saved-search-results`, and a `[user:...]`
  token `search-api-saved-searches-url`.
