# Services, entities, access token, hooks & tokens

## Services

| Service id | Class | Role |
|---|---|---|
| `search_api_saved_searches.new_results_check` | `Service\NewResultsCheck` | Finds and reports new results. Args: `entity_type.manager`, `config.factory`, `datetime.time`, logger channel. |
| `search_api_saved_searches.email_queue` | `Service\EmailQueue` | Collects mails and sends them on request destruction (`needs_destruction`, `DestructableInterface`). Arg: `plugin.manager.mail`. |
| `plugin.manager.search_api_saved_searches.notification` | `Notification\NotificationPluginManager` | Notification plugin manager. |
| `logger.channel.search_api_saved_searches` | (logger channel) | Module logger. |

### NewResultsCheck (the engine)

```php
$svc = \Drupal::service('search_api_saved_searches.new_results_check');
$svc->checkAll();                 // all due searches (all enabled types w/ a plugin)
$svc->checkAll('jobs');           // only type "jobs"; returns count checked
$results = $svc->getNewResults($search);   // ResultSetInterface|null of only-new items
$svc->saveKnownResults($search, $items);   // prime/record seen item IDs
```

- `checkAll()` loads due searches (`getSearchesToCheck()`: `status = TRUE`,
  `next_execution <= now+15`, limited by `cron_batch_size`, tagged
  `search_api_saved_searches_to_check`). Per search it re-checks the owner still holds
  `use <bundle> search_api_saved_searches` (else sets `notify_interval = -1` to stop it),
  updates `last_executed`, then calls each plugin's `notify()`.
- `getNewResults()` clones the stored query, runs it against the index server, and either filters
  by a configured `date_field` (`> last_executed`) or diffs current result item IDs against the
  `search_api_saved_searches_old_results` table. It sets `PROCESSING_BASIC` and a search id of
  `search_api_saved_searches:<id>`.

## Entities

- **`search_api_saved_search`** (content, `SavedSearch`) — base table `search_api_saved_search`.
  Fields: `label`, `uid`/owner, `status` (activated), `created`, `last_executed`,
  `next_execution`, `notify_interval` (list_integer, per-type allowed values), `index_id`,
  `query` (serialized `search_api_saved_searches_query` field), computed `search_keywords`,
  `path`, plus plugin fields (e.g. `mail`). Access handler:
  `SavedSearchAccessControlHandler`; views data: `SavedSearchViewsData`; forms: default/create/edit
  (`SavedSearchForm`/`SavedSearchCreateForm`) + `delete`.
- **`search_api_saved_search_type`** (config bundle, `SavedSearchType`) — see
  [../configure/type.md](../configure/type.md).

Interfaces: `SavedSearchInterface`, `SavedSearchTypeInterface`. Exception:
`SavedSearchesException`.

### Access token (account-independent access)

```php
$token = $search->getAccessToken($operation); // $operation: view|activate|edit|delete
// = Crypt::hmacBase64("search_api_saved_search:{$id}:{$operation}", Settings::getHashSalt())
```

Used to let anonymous owners reach their saved search from an emailed link. The token is
operation-specific and embedded as `?token=` in the entity URLs whenever the owner is anonymous
(`urlRouteParameters()`), or always for the `activate` link. The access handler verifies it with a
constant-time compare; a registered owner is instead matched by user id. Every operation also
requires the `use <bundle> search_api_saved_searches` bundle permission.

## Hooks the module implements (integration-relevant)

| Hook | Effect |
|---|---|
| `hook_cron` | `NewResultsCheck::checkAll()`. |
| `hook_entity_field_storage_info` | Registers notification-plugin field storage for `search_api_saved_search`. |
| `hook_mail` | Dispatches to the notification plugin's `prepareMail()` (mail keys `activate`, `new_results`). |
| `hook_ENTITY_TYPE_presave` (`search_api_saved_search`) | For non-admins, if the `email` plugin's activation mail is on and the address isn't the user's own, deactivates the search and queues an activation mail. |
| `hook_user_insert` / `hook_user_update` | Claims anonymous searches matching a newly-active user's email; deactivates a banned user's searches or those for a type they lost permission to; updates the `mail` field on email change; forwards to `Email::onUserUpdate()`. |
| `hook_user_delete` / `hook_search_api_index_delete` | Deletes saved searches owned by the user / bound to the deleted index. |
| `hook_query_TAG_alter` (`search_api_saved_search_access`) | Listing access: non-admins only see their own searches (anonymous: none). |

## Token integration (`search_api_saved_searches.tokens_hooks.inc`)

Token types `search-api-saved-search` (id, label, owner, created, view-url, activate-url,
edit-url, delete-url) and `search-api-saved-search-results` (count, links), plus a `[user:...]`
token `search-api-saved-searches-url` (the user's saved-searches Views page).
