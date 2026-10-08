# facets_searchbox_widget — agent start

Facets submodule. Adds a **search input** over a facet's item list so users can type-filter
long value lists. Requires `facets`. No config UI of its own — choose the widget on a facet's
settings form at `/admin/config/search/facets`.

Source (widget plugins for the main `facets_widget` type; no new plugin type):
- `src/Plugin/facets/widget/SearchboxLinksWidget.php`, `SearchboxCheckboxWidget.php`.
- JS/CSS in `js/`, `css/`; templates in `templates/`; config schema
  `config/schema/facets_searchbox_widget.schema.yml`.

No permissions, hooks, or services. To build your own widget see the main facets
[plugins docs](../../../facets/3.0.x/agent/plugins/widget-processor.md).
