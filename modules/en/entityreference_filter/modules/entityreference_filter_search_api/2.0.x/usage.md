Views Reference Filter - Search API (entityreference_filter_search_api) is the optional submodule of Views Reference Filter that makes the curated, reference-view-driven exposed filter work on fields indexed in a Search API index. NOTE: release 2.0.0-beta7 (beta).

---

This submodule extends the parent Views Reference Filter to Search API views. It registers one Views filter plugin, `entityreference_filter_view_result_search_api`, implemented by `EntityReferenceFilterViewResultSearchApi`, which simply subclasses the parent's `EntityReferenceFilterViewResult` and mixes in core Search API's `SearchApiFilterTrait` so the same "options come from a separate Entity Reference view" behavior applies to a `search_api_index` table's fields. Its config schema (`views.filter.entityreference_filter_view_result_search_api`) just inherits the parent filter's schema. The parent module's `hook_views_data_alter()` already knows about this variant: when it processes a Search-API-indexed entity-id or entity-reference field it emits the `_entityreference_filter` handler using this plugin id **only if this submodule is enabled** — otherwise the Search API field is skipped entirely. It depends on both `entityreference_filter` and `search_api`, has no admin UI (`configure` is null), and adds no permissions, routes, services, or Drush commands of its own.

---

- Add a curated, reference-view-driven exposed filter to a Search API index view.
- Filter Search-API-indexed content by an indexed entity-reference field with a hand-picked option list.
- Restrict a Search API exposed term filter to a subset of terms via a separate Entity Reference view.
- Build dependent (cascading) exposed filters on a Search API view, reusing the parent's AJAX cascade.
- Populate a Search API facet-like dropdown from a controlled reference view instead of the full index.
- Filter a Solr- or DB-backed Search API view by an indexed nid/uid/tid using the reference-view option list.
- Reuse one Entity Reference reference view to drive both a normal and a Search API exposed filter.
- Enable the Search API variant so `hook_views_data_alter()` attaches the filter to indexed reference fields.
- Keep option ordering controlled by the reference view on a Search API results page.
- Provide editors a short, relevant reference filter on a large search index rather than every value.
- Curate which authors appear in a Search API blog view's exposed author filter.
- Limit a Search API product view's category filter to a marketing-picked set of terms.
- Combine full-text Search API querying with a controlled reference-view dropdown filter.
- Filter indexed multilingual content by a reference field with a curated option list.
- Expose only in-stock or featured referenced entities on a Search API results page.
- Point multiple Search API views at one shared Entity Reference reference display.
- Let a Search API region filter drive a dependent, AJAX-updated store filter.
- Add a curated taxonomy filter to a Search API view without listing the whole vocabulary.
- Keep Search API exposed reference filters consistent with their non-indexed counterparts.
- Disable the submodule to cleanly drop the Search API reference filters again (fields fall back to skipped).
