# Sort-priority processors

Each processor is a `@SearchApiProcessor` (`src/Plugin/search_api/processor/`) enabled on a Search API
index's **Processors** tab (`admin/config/search/search-api/index/<id>/processors`). Enabling one:

1. Creates a hidden integer field on the index (`preIndexSave()` → `ensureField()` + `setHidden()`).
2. At index time (`addFieldValues()`) writes a resolved weight onto each item.
3. Only offers itself for compatible indexes (`supportsIndex()` checks the datasource entity type).

## The six processors

| id | Field created | Applies to (datasource) | Weight comes from |
|---|---|---|---|
| `contentbundle` | `contentbundle_weight` | node | Per node **content type**; weight from the config tabledrag, else default `weight` (0). |
| `mediabundle` | `mediabundle_weight` | media | Per **media bundle**. |
| `paragraphbundle` | `paragraphbundle_weight` | paragraph | Per **paragraph bundle**. |
| `filemime` | `filemime_weight` | file | Per file **MIME type**. |
| `role` | `role_weight` | node (author) | The **highest-weighted role** among the item author's roles (`allowed_entity_types` default `node`, `comment`). |
| `statistics` | `statistics_weight` | node | The node's **total view count** (`totalcount`) from the core `statistics` module. Its config form is empty (no table). |

All except `statistics` render a `#type => 'table'` with `#tabledrag` where each bundle/role is a draggable
row with a `#type => 'weight'` element; the submitted order is saved via
`submitConfigurationForm()` → `setConfiguration($form_state->getValues())` into `sorttable[<id>].weight`.
Lower/negative weight = higher priority when you sort ascending (it stores raw weights; you choose sort
direction in the view).

## Config storage

Processor config is part of the Search API **index** config entity
(`search_api.index.<id>` → `processor_settings.<processor_id>`), e.g.:

```yaml
processor_settings:
  contentbundle:
    weight: 0
    sorttable:
      article:   { weight: -10 }
      page:      { weight: 0 }
```

## Sorting on the weight field

After enabling a processor and **re-indexing**, the `*_weight` field exists (hidden) on the index. To use
it: add it as a sort criterion in a Search API **view** (Sort by → the weight field), or, on Solr, as a Solr
sort. Combine with the relevance/score sort for tie-breaking.

## Notes

- `role` uses `User::load($node->getOwnerId())->getRoles()`, sorts roles by weight, and indexes the top
  role's weight; roles are `Html::escape`d for the form labels only.
- `statistics` requires the core Statistics module (uses `StatisticsViewsResult` / `statisticsGet()`).
- `filemime` only appears for indexes with a `file` datasource; the bundle processors need the matching
  entity datasource.
- For Solr backends also enable `search_api_sort_priority_solr` so these fields index single-valued.
