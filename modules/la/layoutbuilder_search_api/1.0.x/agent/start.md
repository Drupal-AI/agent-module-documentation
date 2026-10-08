# Layout Builder Search API — agent index

Adds one Search API **processor** plugin, `layout_builder_references`, that exposes fields of the
inline/referenced **block content** used in an entity's Layout Builder layout so you can index those
block fields. No settings form (`configure: null`), no permissions, no Drush. All config is on the
Search API index.

- **Enable & configure the processor on an index, the generated fields, and the indexing flow** →
  [plugins/processor.md](plugins/processor.md)
- **The `layoutbuilder_search_api.manager` service (content-block collector)** →
  [api/manager-service.md](api/manager-service.md)

> **Compatibility warning (Drupal 11.4+):** version 1.0.3 is **broken on current core**. The
> processor class declares an untyped `protected $sectionStorageManager;`, but core's
> `LayoutEntityHelperTrait` (used by the class) now declares
> `protected SectionStorageManagerInterface $sectionStorageManager;` — an incompatible property. PHP
> fatals ("define the same property … incompatible") the moment the processor class is composed, i.e.
> whenever Search API instantiates it (enabling it on an index, saving such an index, or opening the
> Processors UI). So on Drupal 11.4 you cannot actually enable/configure this processor until the
> module is patched. The docs below describe intended behavior.

Key facts:
- Processor id `layout_builder_references` (stage `add_properties`). Settings key:
  `block_content_types` (array of block content type ids to expose).
- Generated properties are named `search_api_layoutbuilder_references_<bundle>` (entity-reference,
  `is_list`); add their nested fields on the index's *Fields* tab.
- `supportsIndex()` requires at least one entity datasource. Requires `search_api` + `layout_builder`.
