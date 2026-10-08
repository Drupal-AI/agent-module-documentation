Search API Taxonomy Machine Name is a submodule of Taxonomy Machine Name that lets Search API index taxonomy term machine names — optionally together with all of a term's ancestor machine names — and filter Views on them.

---

The submodule ships two Search API plugins plus a Solr mapping hook. Its processor `taxonomy_machine_name_hierarchy` ("Index machine name hierarchy", class `AddHierarchy`) runs at the `preprocess_index` stage: for each configured taxonomy-machine-name field it walks `loadAllParents()` of every referenced term and adds each ancestor's `machine_name` to the indexed field, turning a leaf-only value into the full hierarchy path. Its Views filter `search_api_taxonomy_machine_name` (class `SearchApiTaxonomyMachineName`, extending the base module's `TaxonomyIndexMachineName` and mixing in `SearchApiFilterTrait`) filters Search API index results by term machine name and adds "Start at level" / "Max depth" options that feed `loadTree()`. A `hook_search_api_solr_field_mapping_alter()` implementation delegates to the processor's `alterFieldMapping()` so that, when hierarchy is enabled, the affected Solr fields become multi-value (`sm_` prefixed). The processor only appears for an index that already has a field whose dependencies include the `taxonomy_machine_name` module (i.e. a term `machine_name` field), and it stores its configuration as a per-field `fields[<field_id>][status]` flag.

---

- Index the machine name of a taxonomy term reference into a Search API index instead of (or beside) its term ID.
- Add every ancestor term's machine name to an indexed field so a search on a parent category also matches children.
- Build faceted search on stable term slugs that survive migration between environments.
- Filter a Search API view by taxonomy term machine name with the dedicated `search_api_taxonomy_machine_name` filter.
- Offer an autocomplete or dropdown of term machine names in an exposed Search API view filter.
- Restrict a hierarchical machine-name filter to a depth range via the "Start at level" and "Max depth" options.
- Enable hierarchical machine-name indexing per field through the processor's checkbox list.
- Make Solr fields multi-value automatically when hierarchy indexing is on (via the Solr field-mapping alter).
- Power a category landing page that queries by a parent term slug and returns all descendant content.
- Combine term-slug faceting with full-text search in one Search API index.
- Keep search filters stable across sites by keying on machine names rather than numeric term IDs.
- Migrate an existing tag/category facet from term IDs to machine names without changing the front-end URLs.
- Index taxonomy hierarchy for breadcrumb-style filtering in decoupled/JSON search front ends.
- Let editors reorganise the term tree while indexed ancestor slugs keep search results consistent.
- Provide a Solr-backed "browse by machine name" experience for large vocabularies.
