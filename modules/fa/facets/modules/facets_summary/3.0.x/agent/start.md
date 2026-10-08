# facets_summary — agent start

Facets submodule (experimental). Adds a **"current search" summary block** aggregating all
active facet filters for a source, with removable chips, a reset link, and result count.
Requires `facets`. Manage summaries at `/admin/config/search/facets` (shares
`entity.facets_facet.collection`; add/edit forms under `facets_summary.routing.yml`).

- Configure a summary + its processors → [configure/summary.md](configure/summary.md)
- Defines a plugin type — add a summary processor → [plugins/summary-processor.md](plugins/summary-processor.md)

Also: Views integration (`src/Plugin/views/filter`, `.../area`), templates in `templates/`,
config schema in `config/schema/`, service `facets_summary.manager`. No permissions or hooks.
