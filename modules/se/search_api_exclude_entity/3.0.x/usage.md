Search API Exclude Entity adds a per-entity checkbox field that lets editors flag individual entities (nodes, etc.) to be left out of a Search API index, via a processor that drops those items during indexing.

---

The module provides a custom `search_api_exclude_entity` boolean field type — plus its own widget and formatter — that you attach to any fieldable entity type/bundle. When an editor ticks the "exclude" checkbox on an entity, a Search API `alter_items` processor (`search_api_exclude_entity_processor`, weight -50) removes that item from the index during indexing. Because it is a real field, the label, description and position are configurable per bundle, you can add several exclude fields on one bundle (one per index/server), and it works with Views out of the box without extra plugins. The processor's settings form lets you pick, per entity type in the index, which exclude field(s) control exclusion — so multiple indexes can honor different fields. Field cardinality is force-hidden (always single value) via a form alter, and editing the exclude value is gated by the `edit search api exclude entity` permission through `hook_entity_field_access()`. It depends on core `field` and `search_api`. Two submodules broaden the idea: Search API Exclude Entity By Field excludes items when any indexed field matches a configured value (no dedicated field needed), and Search API Exclude Entity - Metatag excludes published entities whose Metatag `robots` value contains `noindex`. It is the Drupal 8+/Search API successor to "Apache Solr Node Exclude".

---

- Let editors flag a single node to be omitted from site search without unpublishing it.
- Keep a "thank you" or internal landing page out of the search index while it stays publicly reachable.
- Add a "Exclude from search" checkbox to the Article and Page content types.
- Attach the exclude field to non-node entities (users, taxonomy terms, media) that are indexed.
- Run two search indexes and use a separate exclude field for each on the same bundle.
- Enable the `search_api_exclude_entity_processor` on an index and choose which exclude fields it honors.
- Configure the checkbox label and description per bundle to match editorial language.
- Render the checkbox inside the node form's "advanced" sidebar via the widget's details container.
- Show the exclude status as Yes/No on the entity display using the provided formatter.
- Restrict who can toggle the exclude flag with the `edit search api exclude entity` permission.
- Expose the exclude field as a filter/column in a Views-based search listing.
- Bulk-set the exclude flag on legacy content during a migration so noisy pages never index.
- Prevent duplicate or thin pages from appearing in Solr/database search results.
- Exclude entities per index while still indexing them in a different index.
- Import/export the exclude value with Single Content Sync (field processor plugin provided).
- Exclude items by an arbitrary field value with the By Field submodule (no dedicated field).
- Drop items from the index when a boolean/select field equals `true`, `false`, or a set string (By Field).
- Honor SEO intent by excluding pages whose Metatag `robots` is set to `noindex` (Metatag submodule).
- Keep noindex-marked content out of Search API in sync with what crawlers are told to skip.
- Combine the exclude field with normal Search API processors in the indexing pipeline.
- Deploy processor and field settings as configuration between environments.
- Give each entity type in an index its own set of controlling exclude fields.
- Migrate from Drupal 7 Apache Solr Node Exclude to a Search-API-native workflow.
