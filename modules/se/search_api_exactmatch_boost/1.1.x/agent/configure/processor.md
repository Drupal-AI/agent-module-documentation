<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Exact match boosting processor

No global settings page. Enable and configure it **per index**:
`admin/config/search/search-api/index/<index>/processors` → tick **Exact match boosting** → set its
options in the "Processor settings" section → Save. The index must already be attached to a server.

## Options

| Setting | Type | Default | Effect |
|---|---|---|---|
| `fields` | field list | (none) | Which indexed fields to consider for exact matching. **Only** `text`, `string` and `solr_text_custom` fields are offered (others are removed from the list; the global "all fields" checkbox is hidden). |
| `remove_exacts` | boolean | `FALSE` | After copying an exact match to the top, remove it from its original (lower) position. Reliable only on `string` fields; may misbehave on other types. |
| `disable_full_processing_level` | boolean | `FALSE` | Skip boosting unless the query is `PROCESSING_FULL`. Turn on to keep contexts like autocomplete fast. |

Config schema: `plugin.plugin_configuration.search_api_processor.exactmatchboost` extends
`search_api.fields_processor_configuration` and adds the `remove_exacts` boolean.

## How matching works (`postprocessSearchResults`)

- Reads the query's **original keys**. For each configured field:
  - **Search API DB backend + `string` field** → runs a DB `select` on the field's own table
    (`<backendId>_<indexId>_<field>`) with `condition('value', $search_keys)` (bound placeholder — not
    string-concatenated) and pulls matching `item_id`s. This can promote exact matches that are **not on
    the current page**.
  - **Other backends / field types** → compares the current page's result items in PHP
    (`trim(strtolower(value)) === trim(strtolower(keys))`), so only current-page items can be boosted.
- If the Transliteration processor is enabled on the field, the search keys are transliterated first.
- Exact matches are merged to the front of page 1 (special-casing the "mini" pager); on later pages,
  matches are only removed when `remove_exacts` is on.

## Caveats (from README + form warnings)

- **Pager counts can differ per page**: items are added to page 1 and removed from later pages, so a
  paged display may show more items on the first page and fewer later. Best on **non-paged** displays.
- May not work correctly with the Views **result summary** plugin for the same reason.
- Non-string fields and non-DB backends only affect the first page.
- Reordering happens at query time; no re-index needed.

## Set it with drush (example)

```php
// drush php:eval — enable the processor on an existing index and pick a field.
$index = \Drupal::entityTypeManager()->getStorage('search_api_index')->load('my_index');
$index->addProcessor(\Drupal::service('search_api.plugin_helper')
  ->createProcessorPlugin($index, 'exactmatchboost', [
    'fields' => ['title'],
    'remove_exacts' => TRUE,
    'disable_full_processing_level' => FALSE,
  ]));
$index->save();
```
