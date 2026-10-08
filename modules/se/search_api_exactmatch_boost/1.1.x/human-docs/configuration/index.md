# Configuration

There's no global settings page — you enable and tune **Exact match boosting** per
Search API index, on that index's **Processors** tab.

## Enable the processor

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and open the index you want (it must already
   be attached to a server).
2. Open the index's **Processors** tab
   (`/admin/config/search/search-api/index/<index>/processors`).
3. Tick **Exact match boosting** to enable it.
4. Scroll to the **Processor settings** section to configure it (see below).
5. Click **Save**.

## Settings

- **Fields** — which indexed fields the processor considers for exact matching.
  **Only** `text`, `string`, and `solr_text_custom` fields are offered (other
  field types are removed from the list, and the usual "all fields" checkbox is
  hidden). Pick the fields where an exact match should win — typically a title or a
  code/SKU.
- **Remove exacts** (`remove_exacts`, default off) — after copying an exact match
  to the top, also remove it from its original (lower) position, so it doesn't
  appear twice. This is reliable on `string` fields; on other field types it may
  misbehave, so test it.
- **Disable on non-full processing** (`disable_full_processing_level`, default off)
  — skip the boosting unless the query is a full search. Turn this on to keep
  lighter contexts like **autocomplete** fast, since they don't need the reorder.

## How it behaves by backend

- **Search API DB backend + `string` field** — the processor queries the field's
  own table (with the search keys as a bound parameter, not string-concatenated),
  so it can promote exact matches that aren't on the current results page.
- **Other backends / field types** — it compares only the items already on the
  current page (trimmed, case-insensitive), so only current-page items can be
  boosted.

If the **Transliteration** processor is also enabled on the field, the search keys
are transliterated first, so accented exact matches are recognised.

## Remember the pagination caveat

Because exact matches are merged to the front of page 1 and (with **Remove
exacts**) removed from later pages, a **paged** display may show more items on the
first page and fewer later, and it may not work correctly with the Views **result
summary** plugin. The module works best on **non-paged** displays. Reordering
happens at query time, so no re-index is required.

## Enable it from the command line (optional)

```bash
ddev drush php:eval "\$index = \Drupal::entityTypeManager()->getStorage('search_api_index')->load('my_index');
\$index->addProcessor(\Drupal::service('search_api.plugin_helper')->createProcessorPlugin(\$index, 'exactmatchboost', [
  'fields' => ['title'],
  'remove_exacts' => TRUE,
  'disable_full_processing_level' => FALSE,
]));
\$index->save();"
```
