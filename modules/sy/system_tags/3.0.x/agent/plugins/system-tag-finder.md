# `SystemTagFinder` plugin type

Resolves "the entity of type X tagged with tag Y". One finder plugin per entity type.

## Plugin machinery

- Manager service: `plugin.manager.system_tags.system_tag_finder_manager`
  (`SystemTagFinder\SystemTagFinderManager`), namespace `Plugin/SystemTagFinder`, interface
  `SystemTagFinderInterface`, annotation `@SystemTagFinder`, alter hook `system_tag_finder_info`.
- Annotation keys: `id`, `entity_type` (the entity type the plugin queries).
- Base class `SystemTagFinder\SystemTagFinderPluginBase` implements all query logic; concrete plugins
  are usually empty and only carry the annotation.
- `$manager->getInstance(['entity_type' => 'node'])` returns the plugin whose `entity_type` matches
  (throws `PluginException` if none).

## Built-in finders

- `system_tag_node_finder` → `node`
- `system_tag_block_finder` → `block_content`

## Interface

```php
findByTag($systemTagId, $langcode = NULL): EntityInterface[]   // newest-changed first
findOneByTag($systemTagId, $langcode = NULL): ?EntityInterface  // first of the above, or NULL
```

Base implementation: finds all reference fields on the entity type that target `system_tag`
(`SystemTagHelper::getReferenceFieldNames()`), builds an OR group of `exists + equals tagId`
conditions, and applies:
- `accessCheck()` and an `<entityType>_access` query tag,
- published-status filter when the entity type has a `status` key (so unpublished entities are
  excluded),
- `sort('changed', 'DESC', $langcode)`,
- language fallback: results are swapped to their `$langcode` translation when present, and `langcode`
  is added as query metadata.

## Adding a finder for a new entity type

Create a plugin class under `src/Plugin/SystemTagFinder/` extending `SystemTagFinderPluginBase`:

```php
/**
 * @SystemTagFinder(
 *   id = "system_tag_term_finder",
 *   entity_type = "taxonomy_term"
 * )
 */
class SystemTagTermFinder extends SystemTagFinderPluginBase {}
```

Then `system_tag_url('my_tag', 'taxonomy_term')`, tokens, and any code calling
`getInstance(['entity_type' => 'taxonomy_term'])` will resolve tagged terms. Override methods only if
the default reference-field query is not sufficient.
