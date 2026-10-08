# Choices.js Facets — agent index

Submodule of **Choices.js** ([parent](../../../../2.2.x/agent/start.md)) providing one Facets
widget plugin. Depends on `facets` and `choices`. No config UI, no permissions, no schema, no Drush.

- **The `choices_js` Facets widget (how it builds the select, classes, library)** →
  [plugins/widget.md](plugins/widget.md)

Key facts:
- Plugin `\Drupal\choices_facets\Plugin\facets\widget\ChoicesWidget` — `@FacetsWidget(id="choices_js")`,
  extends `WidgetPluginBase`.
- Selected in a facet's config at *Search > Facets* → facet → Widget = "Choices.js".
- Builds a `#type => select` element: options keyed by result URL, `#value` = active result URLs,
  `#multiple` unless the facet is "show only one result".
- Attaches library `choices_facets/widget` (depends on `facets/widget`, `choices/choices`);
  `js/choices-widget.js` wires Choices into the Facets JS API.
