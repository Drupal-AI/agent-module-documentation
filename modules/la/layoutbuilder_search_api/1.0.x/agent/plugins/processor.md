# The `layout_builder_references` Search API processor

`Drupal\layoutbuilder_search_api\Plugin\search_api\processor\LayoutBuilderReferences`
(`@SearchApiProcessor(id="layout_builder_references", label="Layout builder references")`, stage
`add_properties`). Uses `LayoutEntityHelperTrait`.

## Enable & configure (on the index, not a module page)

1. Search API index → **Processors** tab → enable **"Layout builder references"**.
2. In its settings, tick the **Block Content Types** you want exposed (checkboxes built from all
   `block_content_type` entities). Stored as `block_content_types` in the processor config.
3. Index → **Fields** tab → *Add fields* → under each enabled block type you'll find the block's
   fields (nested under the generated property) — add the ones to index.

Config lives inside the index config entity
(`search_api.index.<id>` → `processor_settings.layout_builder_references.block_content_types`).

## Generated properties (`getPropertyDefinitions()`)

For each selected block content type `<bundle>` it adds one property:

- key: `search_api_layoutbuilder_references_<bundle>`
- an `EntityProcessorProperty` of type `entity:<entity_type>` (usually `block_content`), `is_list =
  TRUE`, bundle-restricted to `<bundle>`, label `"Layoutbuilder Block Content: <label>"`.

Only added when the datasource has an entity type (`supportsIndex()` needs an entity datasource).

## Indexing flow (`addFieldValues()`)

For each indexed entity:
1. Reads the entity's Layout Builder sections (`getEntitySections()`).
2. Collects components: inline blocks via `getInlineBlockComponents()` **plus** placed reusable
   block content via the `layoutbuilder_search_api.manager` service.
3. For an `inline_block` it uses the component's `block_revision_id`; for placed `block_content` it
   loads the block by the component's UUID (`entity.repository`) and takes its current revision.
4. Loads each block's `block_content` **revision** and extracts the requested fields for the item's
   language (`getFieldsHelper()->extractFields()`), so the index stores the block field values that
   are actually on the page.

## Reference/label cache

`getBlockReferences()` builds the bundle→fields map and caches it under
`search_api:layoutbuilder_references:<langcode>` (cache tags: `entity_types`, `entity_bundles`,
`entity_field_info`), varied per language because property labels are translated.

No config schema ships with the module; the processor relies on Search API's generic processor
settings handling.
