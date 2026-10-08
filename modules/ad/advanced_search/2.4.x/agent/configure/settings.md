# Configure Advanced Search

Global settings form. Route **`advanced_search.settings`** at `/admin/config/search/advanced`
(menu link under `system.admin_config_search`), gated by core permission
**`administer site configuration`**. Form `Drupal\advanced_search\Form\SettingsForm`
(`getFormId()` = `advanced_search_settings_form`), form id constant `SettingsForm::CONFIG_NAME`.
Settings are read all over the module through `GetConfigTrait::getConfig($key, $default)`, which
returns the default whenever the stored value is empty.

## Config object `advanced_search.settings`

| Key | Type | Constant | Default | Meaning |
|---|---|---|---|---|
| `lucene_on_off` | int | `EDISMAX_SEARCH_FLAG` | 1 (on) | Use Solr Extended DisMax (eDisMax) for Advanced Search Block queries. Must be on for the Simple Search Block and the "all fields" option. |
| `lucene_label` | string | `EDISMAX_SEARCH_LABEL` | `Keyword` | Label of the "search all fields" option in the block (code fallback in `AdvancedSearchForm::getEdismaxSearchLabel()` is `All`). |
| `all_fields_on_off` | int | `SEARCH_ALL_FIELDS_FLAG` | 0 | Expose an "all fields" option in Advanced Search Blocks; required for the Simple Search Block to work. |
| `list_on_off` | int | `DISPLAY_LIST_FLAG` | 0 | Expose the "List view" toggle on the pager block. |
| `grid_on_off` | int | `DISPLAY_GRID_FLAG` | 0 | Expose the "Grid view" toggle on the pager block. |
| `default-display-mode` | string | `DISPLAY_DEFAULT` | `grid` | Default results display (`list` or `grid`). |
| `search_query_parameter` | string | `SEARCH_QUERY_PARAMETER` | `a` | URL query key carrying search terms (`a[N][...]`). |
| `search_recursive_parameter` | string | `SEARCH_RECURSIVE_PARAMETER` | `r` | URL query key flagging recursive (sub-collection) search. |
| `search_add_operator` | string | `SEARCH_ADD_OPERATOR` | `+` | Button glyph to add a term row in the Advanced Search form. |
| `search_remove_operator` | string | `SEARCH_REMOVE_OPERATOR` | `-` | Button glyph to remove a term row. |
| `facet_truncate` | int (string) | `FACET_TRUNCATE` | 32 | Max characters of a facet label before truncation (`hook_preprocess_facets_result_item`). |
| `recursive` | int | `RECURSIVE_FLAG` | 0 | Search collections recursively by default (user can override per query). |
| `query_fields` | sequence\<string\> | `QUERY_FIELDS` | `[]` | Search API field identifiers to query when "all fields" is used. Empty = every field on the index. |
| `no_follow` | int | `NO_FOLLOW` | 0 | Add `rel="nofollow"` to pager / per-page / display-mode links. |

The form also builds `query_fields` checkboxes from every field of every `search_api_index`
(`SettingsForm::getAvailableFields()`), and only `visible` value gets saved
(`array_filter` in `submitForm()`).

## Set it with Drush / PHP

```php
\Drupal::configFactory()->getEditable('advanced_search.settings')
  ->set('lucene_on_off', 1)
  ->set('all_fields_on_off', 1)
  ->set('lucene_label', 'Keyword')
  ->set('list_on_off', 1)
  ->set('grid_on_off', 1)
  ->set('default-display-mode', 'grid')
  ->set('facet_truncate', 32)
  ->set('recursive', 0)
  ->set('query_fields', ['title', 'body'])   // Search API field ids; [] = all fields
  ->set('no_follow', 0)
  ->save();
```

Or: `drush config:set advanced_search.settings all_fields_on_off 1 -y`.

## Config schema

`config/schema/advanced_search.schema.yml` declares `advanced_search.settings` (config_object, the
keys above) and `block.settings.search_block` (the Simple Search Block settings — see
[blocks/blocks.md](../blocks/blocks.md)). Per-block override settings for the pager block are stored
in the block config, not this object.
