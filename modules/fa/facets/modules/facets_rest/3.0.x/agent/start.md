# facets_rest — agent start

Facets submodule. Adds facets to **REST-export Views** over a Search API index, so JSON
responses include facets + counts for decoupled clients. Requires `facets`, `rest`.

Source (single Views style plugin — no new plugin type, no config UI, no permissions):
- `src/Plugin/views/style/FacetsSerializer.php` — serializer style that appends facet data.
- Config schema `config/schema/facets.views.styles.schema.yml`.

Setup: create a REST export display on a Search API view, set its style to the Facets
serializer, and point your facets at that display as their source (via the main facets admin
at `/admin/config/search/facets`). Trivial glue module — see the main facets docs for the
rest.
