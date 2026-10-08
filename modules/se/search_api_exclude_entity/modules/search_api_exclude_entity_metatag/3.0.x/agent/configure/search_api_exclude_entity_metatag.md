# Configure — exclude on Metatag robots noindex

No settings form and no config schema — just **enable the processor** on the index.

## The processor

- ID: `search_api_exclude_entity_processor_metatag`
- Label: "Search API Entity Exclude - Metatag No Index"
- Stage: `alter_items`, weight `0`
- Class: `SearchApiExcludeEntityProcessorMetatag extends ProcessorPluginBase`
- Depends on `metatag` (injects `metatag.manager`).

## Behavior (`alterIndexedItems`)

For each item it takes the original object; only entities implementing
`EntityPublishedInterface` are considered (unpublished are ignored). It calls
`MetatagManager::tagsFromEntity($entity)` and iterates the resulting tags; if the `robots`
tag's value contains the substring `noindex`, the item is `unset()` and excluded from the
index.

So any entity you already mark `noindex` in Metatag (per-entity override, or via bundle/global
Metatag defaults) is automatically kept out of the Search API index — no dedicated field, no
per-field configuration. Enable it on the index's **Processors** tab; reindex to apply.
