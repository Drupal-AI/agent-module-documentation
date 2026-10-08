Search API Exclude Entity - Metatag keeps published entities out of a Search API index when their Metatag robots value contains `noindex`, aligning the search index with SEO crawler directives.

---

This submodule adds a Search API processor, `search_api_exclude_entity_processor_metatag` (`alter_items` stage, weight 0), that has no settings form — enabling it is all that is needed. During indexing `alterIndexedItems()` loops the items; for any item whose original object implements `EntityPublishedInterface`, it asks the Metatag manager (`metatag.manager` → `tagsFromEntity()`) for the entity's computed tags, and if the `robots` tag value contains the substring `noindex`, it `unset()`s the item so the entity is dropped from the index. This means the same `noindex` directive you set for search engines also removes the page from your on-site Search API results, with no extra per-entity field. It depends on the `metatag` module and on the parent `search_api_exclude_entity`. Only published entities are considered.

---

- Exclude pages you already marked `noindex` for crawlers from your on-site search too.
- Keep index results consistent with the Metatag `robots` directives across content.
- Suppress thin or duplicate pages from Search API without a dedicated exclude field.
- Honor per-entity Metatag overrides that set `robots: noindex`.
- Align SEO strategy and internal search visibility with one setting.
- Drop noindex-tagged articles/pages from a Solr or database Search API index.
- Exclude landing pages tagged noindex while keeping them publicly reachable.
- Avoid indexing staging or campaign pages flagged noindex in Metatag defaults.
- Reindex and automatically omit anything whose robots value gained `noindex`.
- Combine with the parent processor to exclude by both a checkbox and noindex.
- Apply the exclusion only to published entities (unpublished are skipped by design).
- Use Metatag's global/bundle defaults so whole content types can be excluded via `noindex`.
- Keep the search index in sync when editors toggle noindex on a node.
- Exclude entities of any type that exposes Metatag tags and is published.
- Remove noindex content from faceted/Views search built on the index.
- Enforce noindex intent without writing a custom Search API processor.
- Layer the Metatag exclusion alongside other Search API processors in the pipeline.
- Reduce index size by omitting pages intentionally hidden from search engines.
