# Configure — sort fields per display

There is no global settings form (`configure = null`). Sorting is configured **per Search API
display** and stored in `search_api_sorts_field` config entities.

## Admin UI

- `/admin/config/search/search-api/index/{index}/sorts` — lists the index's displays
  (route `entity.search_api_index.sorts`). A display is any place the index is shown
  (a Views page/block on the index, a Search API Pages page, etc.).
- `/admin/config/search/search-api/index/{index}/sorts/{display}` — the **Manage sort fields**
  form (route `search_api_sorts.search_api_display.sorts`, form `ManageSortFieldsForm`).
  Tick "Enabled" per field, pick a "Default sort" radio, set default order, label and weight.
- Both routes require the core **`administer search_api`** permission (the module defines no
  permissions of its own).
- Only single-value string/number fields are offered; `text` (fulltext) and `list<...>`
  (multi-value) fields are skipped. A synthetic `search_api_relevance` option is always present.

## The `search_api_sorts_field` config entity

`@ConfigEntityType(id="search_api_sorts_field", config_prefix="search_api_sorts_field")`.
`config_export` keys: `id`, `display_id`, `field_identifier`, `status`, `default_sort`,
`default_order`, `label`, `weight`.

- **id** = `{escaped_display_id}_{field_identifier}`. Display ids can contain a colon
  (e.g. `views_page:search__page_1`); colons are escaped to `---` for the config id/`display_id`
  via `ConfigIdEscapeTrait` (`str_replace(':', '---', $id)`). Full config name:
  `search_api_sorts.search_api_sorts_field.<id>`.
- **display_id** — the escaped Search API display plugin id.
- **field_identifier** — the indexed field's identifier (or `search_api_relevance`).
- **status** — enabled. The UI only persists enabled fields and deletes a field's config when
  it is un-ticked (keeps the config set minimal). Direct code creation may keep `status: FALSE`.
- **default_sort** (bool) — this field is the display's default sort (at most one).
- **default_order** — `asc` or `desc`.
- **label**, **weight** — display label and ordering of the sort link.

## Create a sort field in code / Drush

```php
use Drupal\search_api_sorts\Entity\SearchApiSortsField;
// display_id must be the ESCAPED plugin id (colon -> ---), e.g. 'views_page---search__page_1'.
SearchApiSortsField::create([
  'id' => 'views_page---search__page_1_price',
  'display_id' => 'views_page---search__page_1',
  'field_identifier' => 'price',
  'status' => TRUE,
  'default_sort' => TRUE,
  'default_order' => 'desc',
  'label' => 'Price',
  'weight' => 0,
])->save();
```

```bash
drush php:eval '\Drupal\search_api_sorts\Entity\SearchApiSortsField::create([...])->save();'
```

## Runtime

- `search_api_sorts.manager` (`SearchApiSortsManagerInterface`): `getEnabledSorts($display)`,
  `getActiveSort($display)` (from `?sort`/`?order`), `getDefaultSort($display)` (the
  `default_sort` field, else `search_api_relevance` desc), `cleanupSortFields($index)`.
- `SearchApiSortsQueryPreExecute` (event subscriber) applies the active/default sort to the
  Search API query before execution.
- `hook_ENTITY_TYPE_update()` for `search_api_index` calls `cleanupSortFields()` to drop sort
  fields whose indexed field no longer exists.
