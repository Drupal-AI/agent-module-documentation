# select2_facets — agent start

Submodule of **select2**. Registers a `select2` Facets widget so a facet renders as a searchable
Select2 dropdown (single or multi-select), reusing the parent `#type => 'select2'` element.
Supports AJAX autocomplete of facet values via `select2_facets.facet_autocomplete`. Depends on
`facets` and `select2`. No global settings form — config is per-facet.

- Enable & configure the Select2 facet widget (width, autocomplete, matching) → [configure/select2_facets.md](configure/select2_facets.md)
- The facet autocomplete route + widget internals; reusing the select2 element → [extend/select2_facets.md](extend/select2_facets.md)
- Parent module: [select2](../../../../2.0.x/agent/start.md)
