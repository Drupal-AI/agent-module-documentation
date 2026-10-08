# How similarity is computed

## Data exposure (`SimilartermsHooks::viewsDataAlter`)

`hook_views_data_alter()` adds the handlers. Two modes:

- **Default (nodes only).** Uses core's `taxonomy_index` table (which only indexes published
  nodes). Adds `node.similar_nid` (argument), `node.similarterms` (field + sort).
- **With `taxonomy_entity_index` enabled.** Iterates every content entity type with a base table
  and id key, exposing `<base>.similar_<idkey>` and `<base>.similarterms` and using the
  `taxonomy_entity_index` table (which covers term references on any entity type). The join is
  restricted by `entity_type`.

## The argument handler (`SimilarTermsArgument::validateArgument` + `query`)

- On validate, it loads the **term IDs** of the argument entity from the index table
  (`taxonomy_index` or `taxonomy_entity_index`), optionally filtered to the configured
  `vocabularies` (joining `taxonomy_term_data` on `vid`). The tids are stored on
  `$this->tids` and `$view->tids`.
- On query, it adds a **LEFT JOIN** (`similarterms_taxonomy_index`) from the base entity id to
  the index table on `tid IN (<argument's tids>)`. LEFT (not INNER) so entities with zero matches
  still appear (useful with a sort to "fill" the list). It groups by the entity id.
- `include_args = false` adds `WHERE base.id NOT IN (<argument ids>)` to drop the source entity.
- `min_match_percentage > 0` adds `HAVING COUNT(DISTINCT ...tid) >= ceil(total_terms * pct/100)`.
  If the argument entity has no terms and a minimum is required, it forces `1 = 0` (no results).

## The field (`SimilarTermsField::query` + `render`)

- `count_type 0/1`: adds `COUNT(similarterms_taxonomy_index.tid)` (matching terms). `1` renders
  `round(count / count(view->tids) * 100)` with optional `%`.
- `count_type 2` (weights): additionally LEFT JOINs `taxonomy_term_field_data` on the matched
  `tid` and returns `SUM(weight)` of matching terms, with optional `weight_suffix`.
- Falls back to counting the entity id when the taxonomy relationship is absent (argument entity
  had no terms).

## The sort (`SimilarTermsSort::query`)

- `sort_method = count` (default): `ORDER BY COUNT(base.id)` — number of matching terms.
- `sort_method = weight`: LEFT JOINs `taxonomy_term_field_data` and `ORDER BY SUM(weight)` of the
  matched terms; falls back to count if there is no taxonomy relationship.

## Consequences an agent should know

- Out of the box only **published nodes** are eligible (core `taxonomy_index`). For other entity
  types or unpublished coverage, enable `taxonomy_entity_index` and re-index.
- Similarity is only computed between entities of the **same** base type as the view.
- Term **weight** (the standard taxonomy term weight field) is what weight-based sort/field use;
  with all weights at the default `0`, weight mode equals count mode.
- These are Views **handler plugins on existing handler types**, not a new plugin type — there is
  no `plugins` doc because there is no plugin manager to implement against.
