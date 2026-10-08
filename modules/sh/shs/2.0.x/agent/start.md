# shs — agent start

Simple Hierarchical Select turns a taxonomy term-reference field into cascading level dropdowns:
each level's children load on demand from a JSON endpoint. Provides the `options_shs` **field
widget**, the `entity_reference_shs` **formatter**, and cascading overrides of the core Views
term filters. Depends on core `taxonomy`. No config UI (no `configure` route); everything is set
per field on the form/display config. Submodule: `shs_chosen` (adds Chosen styling).

- Use the widget on a term field, cascading dropdowns, settings, the AJAX children endpoint,
  Views exposed filter, formatter → [configure/shs.md](configure/shs.md)
- Services, controller, and the alter hooks (`shs.api.php`) → [api/shs.md](api/shs.md)
- Libraries, Backbone models/views, CSS, formatter theming → [theming/shs.md](theming/shs.md)
