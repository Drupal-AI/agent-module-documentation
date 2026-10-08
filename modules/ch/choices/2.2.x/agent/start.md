# Choices.js — agent index

Integrates the vanilla [Choices.js](https://github.com/Choices-js/Choices) library to enhance `<select>`
elements. Two modes: **global** (by CSS selector, via a `#pre_render` on the `select` element) and a
**field widget** (`choices_widget`). One settings page (`choices.admin`,
`/admin/config/user-interface/choices`, permission `administer site configuration`). Config schema
present; no permissions of its own, no Drush. Requires the Choices JS library (local `/libraries/` or CDN).

- **Settings page keys, defaults, global vs widget config, CDN vs local library** →
  [configure/settings.md](configure/settings.md)
- **The `choices_widget` field widget (field types, per-field JSON options, merge order)** →
  [plugins/widget.md](plugins/widget.md)
- **How global mode attaches to selects + `drupalSettings` shape for custom code** →
  [api/global.md](api/global.md)

Submodule (own docs):
- `choices_facets` (Facets widget) → [../../modules/choices_facets/2.2.x/agent/start.md](../../modules/choices_facets/2.2.x/agent/start.md)

Key facts:
- Config object `choices.settings`: `use_cdn` (bool), `enable_globally` (bool), `css_selector` (string,
  default `select[multiple]`), `include` (int: 2=everywhere, 0=admin only, 1=front-end only),
  `configuration_options` (string, JSON).
- Widget `choices_widget` (extends `OptionsSelectWidget`) works on `entity_reference`, `list_integer`,
  `list_float`, `list_string`; per-widget setting `configuration_options` (JSON).
- Options merge precedence: **widget options > global options > Choices library defaults**.
- CDN toggle flips the library between local `/libraries/choices.js/...` and jsDelivr via
  `hook_library_info_alter()`.
