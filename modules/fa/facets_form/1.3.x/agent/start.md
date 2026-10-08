<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form — agent index

Renders a facets source's facets as Form API elements in one submit-driven block/form (filters
apply on submit, not on click). Depends on `facets`. No config page (`configure` null), no
permissions, no Drush. Ships config schema for the block + widget settings. Does **not** define its
own plugin type — it plugs into the Facets *widget* plugin type.

- **Place & configure the block, the two shipped widgets and their settings, config keys** →
  [configure/block-and-widgets.md](configure/block-and-widgets.md)
- **Build your own in-form facet widget (`FacetsFormWidgetInterface`, the trait, submit → URL flow)** →
  [plugins/widgets.md](plugins/widgets.md)
- **Theming the option labels (`facets_form_item` template + suggestions)** →
  [theming/templates.md](theming/templates.md)
- **The JS widget-change event (`TriggerWidgetChangeJavaScriptEvent`) + `js/plugin/<id>.js` snippets** →
  [hooks/events.md](hooks/events.md)

Submodules (own docs):
- `facets_form_date_range` → [../../modules/facets_form_date_range/1.3.x/agent/start.md](../../modules/facets_form_date_range/1.3.x/agent/start.md)
- `facets_form_date_range_extended` → [../../modules/facets_form_date_range_extended/1.3.x/agent/start.md](../../modules/facets_form_date_range_extended/1.3.x/agent/start.md)
- `facets_form_fulltext` → [../../modules/facets_form_fulltext/1.3.x/agent/start.md](../../modules/facets_form_fulltext/1.3.x/agent/start.md)
- `facets_form_live_total` (deprecated) → [../../modules/facets_form_live_total/1.3.x/agent/start.md](../../modules/facets_form_live_total/1.3.x/agent/start.md)

Key facts:
- Block plugin `facets_form`, one derivative per facets source (`FacetsFormBlockDeriver`). Category
  "Facets", admin label "Facet form: <source>".
- Shipped widgets: `facets_form_dropdown`, `facets_form_checkbox` (both extend Facets `ArrayWidget`,
  use `FacetsFormWidgetTrait`).
- Submit → each widget `prepareValueForUrl()` → `facets.utility.url_generator` → redirect to the
  filtered URL. Reset = current URL minus the `f` query param.
