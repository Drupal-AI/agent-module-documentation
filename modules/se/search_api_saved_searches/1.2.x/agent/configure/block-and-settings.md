# "Save search" block + module settings

## The "Save search" block

Plugin: `SaveSearch` (block id `search_api_saved_searches`, admin label "Save search",
category "Forms"). Place at `/admin/structure/block`, typically near/below a Search API search
view so the user can save the search they just ran.

- Block setting `type` (schema `block.settings.search_api_saved_searches`): which
  `search_api_saved_search_type` the block creates. Chosen in the block config form
  (`blockForm()`), stored via `blockSubmit()`.
- `access()`: block is visible only if the user passes `createAccess` for that saved-search type —
  i.e. they hold `use <type_id> search_api_saved_searches` (or `administer search_api_saved_searches`).
- `build()`: finds the current page's Search API query via `SavedSearchType::getActiveQuery()`
  (matching the type's configured `displays`). If a matching executed query exists, it creates an
  unsaved `search_api_saved_search` (with `type`, `index_id`, the cloned `query`, and the sanitized
  current `path`) and renders the `create` entity form (`SavedSearchCreateForm`, AJAX submit,
  submit label "Save search"). The block sets `max-age = 0` (there is no cache context for
  "search query on this page"), which is why the source search view must not be cached.

There is no admin form to build the block's query; the query is taken from whatever Search API
search executed on the same page request.

## Module settings object

`search_api_saved_searches.settings` (schema
`config/schema/search_api_saved_searches.settings.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cron_batch_size` | int | `10` | Max saved searches checked per cron run. `0` = no limit (discouraged; there can be tens of thousands). |

There is no dedicated settings form for this object; set it with config:

```php
\Drupal::configFactory()->getEditable('search_api_saved_searches.settings')
  ->set('cron_batch_size', 50)->save();
```

```bash
drush config:set search_api_saved_searches.settings cron_batch_size 50 -y
```

`NewResultsCheck::getSearchesToCheck()` applies this limit (ordering by `next_execution`) unless it
is `0`.

## Optional Views

Two Views are installed as optional config (present only if Views is enabled):
`views.view.saved_searches` (route `view.saved_searches.page`, a per-user "my saved searches"
listing used by the `[user:search-api-saved-searches-url]` token; argument validated by
`CurrentAuthenticatedUser`) and `views.view.saved_searches_admin` (admin overview).
