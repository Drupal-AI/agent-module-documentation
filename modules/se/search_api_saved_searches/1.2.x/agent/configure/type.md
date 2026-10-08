# Configure a saved-search type

A **saved-search type** (`search_api_saved_search_type`, config prefix
`search_api_saved_searches.type.*`) is the bundle for `search_api_saved_search` entities. It
decides which searches can be saved, how notifications are sent, the notification schedule, and
how "new" results are detected. A `default` type ships in `config/install`.

UI: `/admin/config/search/search-api-saved-searches` (route
`entity.search_api_saved_search_type.collection`, permission
`administer search_api_saved_searches`) → add/edit type. Form: `SavedSearchTypeForm`.

## Config-entity structure (`config_export`)

| Key | Meaning |
|---|---|
| `id` / `label` | Machine name + human label of the type. |
| `description` | Admin-only description of the type. |
| `notification_settings` | Map keyed by notification plugin id → that plugin's config. See below. |
| `options` | Behavioural settings (displays, date_field, max_results, notify_interval, query_limit, description). |

`options` schema (`config/schema/search_api_saved_searches.type.schema.yml`):

| Option | Type | Meaning |
|---|---|---|
| `displays.default` | bool | Whether `selected` is an exclude list (TRUE) or an include list (FALSE). |
| `displays.selected` | string[] | Search API **display** plugin IDs this type applies to. `SavedSearchType::getActiveQuery()` matches the current page's query against these. |
| `date_field` | map (index_id → field) | Per index: a date field name → "new = created after `last_executed`"; empty → "determine by result ID" (diff against `search_api_saved_searches_old_results`). |
| `description` | text | User-facing text shown above the save form (rendered with `Xss::filterAdmin`). |
| `max_results` | int | Cap on how many new results are reported per run. |
| `notify_interval.customizable` | bool | Let the user pick their interval. |
| `notify_interval.default_value` | int (seconds) | Default interval (default `86400`). |
| `notify_interval.options` | seq | Allowed interval options (key = seconds, `-1` = Never), e.g. Hourly/Daily/Weekly/Never. |
| `query_limit` | int | Limit set on the re-run query when detection is "by result ID". |

## The `email` notification plugin config

`notification_settings.email` (schema
`plugin.plugin_configuration.search_api_saved_searches_notification.email`):

| Key | Meaning |
|---|---|
| `registered_choose_mail` | Allow logged-in users to enter a different email than their account's. |
| `activate.send` | Require anonymous (or "other email") searches to be confirmed via an activation link. |
| `activate.title` / `activate.body` | Activation mail subject/body (Token-replaced). |
| `notification.title` / `notification.body` | New-results mail subject/body (Token-replaced). |

Available Token types in the mails: `[site:*]`, `[user:*]`, `[search-api-saved-search:*]`
(id, label, owner, created, view-url, activate-url, edit-url, delete-url), and for the
notification mail `[search-api-saved-search-results:count|links]`.

## Set it with PHP

```php
use Drupal\search_api_saved_searches\Entity\SavedSearchType;

$type = SavedSearchType::create([
  'id' => 'jobs',
  'label' => 'Job alerts',
  'notification_settings' => [
    'email' => [
      'registered_choose_mail' => FALSE,
      'activate' => ['send' => TRUE, 'title' => 'Activate your alert at [site:name]', 'body' => "…[search-api-saved-search:activate-url]…"],
      'notification' => ['title' => 'New jobs at [site:name]', 'body' => "…[search-api-saved-search-results:links]…"],
    ],
  ],
  'options' => [
    'notify_interval' => ['customizable' => TRUE, 'default_value' => 86400, 'options' => [3600 => 'Hourly', 86400 => 'Daily', -1 => 'Never']],
    'max_results' => 20,
  ],
]);
$type->save();
```

Notification plugins are instantiated lazily (`getNotificationPlugins()`); changes made to plugin
objects are flushed back into `notification_settings` in `preSave()`/`__sleep()`. On save the type
creates a `create` entity-form-display for the bundle and syncs plugin-defined field storage
(`Email` adds a required `mail` field).

## Runtime / what happens

- On save (create) of a type, `SavedSearchType::postSave()` builds the `*.create` form display and
  calls `adaptFieldStorageDefinitions()` to add/remove plugin fields (e.g. `mail`).
- `hook_cron` → `NewResultsCheck::checkAll()` loads saved searches whose `next_execution` is due
  (batched by `cron_batch_size`), re-runs each query, and calls each plugin's `notify()` for new
  results. See [../api/services-and-hooks.md](../api/services-and-hooks.md).
- Deleting a type deletes its saved searches (`postDelete`), even though the UI blocks deleting a
  type that still has searches.

## Known configuration requirement

Search **views** used for saving should have caching disabled, and should not combine facets with
AJAX, so the exact per-request query is captured. See the module README and drupal.org issues
#3061088 / #3251247.
