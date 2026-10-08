# Configure Synonyms Search

No settings form of its own. Setup is: enable the behavior, then let core Search index.

## Enable the behavior

1. Ensure core **Search** is enabled and a search page (e.g. *Content*) exists and is being indexed.
2. Go to *Structure → Synonyms configuration → Manage behaviors* for the entity type/bundle whose
   synonyms you want indexed (the **referenced** entity, e.g. the taxonomy vocabulary), and enable
   **Search**. This writes config `synonyms_search.behavior.<entity_type>.<bundle>` with
   `status: true` (+ `wording`).
3. Make sure a Synonym provider is configured for that entity type/bundle (so it actually has synonyms).

## How it indexes (behavior)

- Only the **host** entity that has an `entity_reference` field pointing at a synonym-enabled entity gets
  the extra text. During `search_index` rendering, `SearchService::entityView()` collects the referenced
  entities' synonyms and adds them as comma-joined `#markup` to the indexed build.
- The referenced entity's *own* page is unaffected — synonyms are added to the *referrer's* index entry.

## Reindexing

Triggered automatically:
- Host entity `update`/`delete` → its dependent index rows marked for reindex.
- A `synonym` config `insert`/`update`/`delete` → entities of the controlled type/bundle marked for reindex.

Both paths run a direct `UPDATE {search_dataset} SET reindex = <request_time>` filtered by
`type = '<entity_type>_search'` and the affected `sid`s. After changes, run cron / the search indexer to
rebuild. If results look stale, confirm the behavior is enabled and re-run indexing.
