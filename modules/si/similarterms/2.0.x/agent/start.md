# Similar By Terms — agent index

Provides three **Views handlers** to build "related content" lists from shared taxonomy terms.
No admin UI, no configure route, no permissions, no Drush, no plugin *types* of its own — it
adds handler plugins via `hook_views_data_alter()` (`SimilartermsHooks::viewsDataAlter`). Config
lives inside each **view config entity** (`views.view.<id>`).

- **The three handlers, their option keys, and how to add them to a view** →
  [configure/views-handlers.md](configure/views-handlers.md)
- **How similarity is computed (taxonomy_index join, min-match, weights, entity-index mode)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- On the `node` table by default: argument `similar_nid` (handler id `similar_terms_arg`),
  sort `similar_terms_sort`, field `similarterms` (handler id `similar_terms_field`), all in the
  Views group **"Similar by terms"**.
- With `taxonomy_entity_index` enabled, the same handlers appear on **every** content entity
  type (uses `taxonomy_entity_index` instead of core `taxonomy_index`); the node argument is then
  labelled "Content ID".
- Config schema ids: `views.argument.similar_terms_arg`, `views.field.similar_terms_field`,
  `views.sort.similar_terms_sort`.
