# Provisioning & adding your own bundle

## How a bundle's fields get installed

Each submodule ships its paragraph type + fields as YAML in `config/optional/`
(`paragraphs.paragraphs_type.<bundle>.yml`, `field.storage.paragraph.*`, `field.field.paragraph.*`, and
default form/view displays). Enabling a submodule installs that config. The base module adds helpers in
`paragraphs_bundles.module` to make provisioning robust:

- `paragraphs_bundles_import_optional_config_if_missing($module, $config_name)` — imports a specific
  `config/optional` record if it does not yet exist.
- `paragraphs_bundles_ensure_pb_title_storages()` / `paragraphs_bundles_pb_title_*` — ensure and wire the
  shared `pb_content_title*` fields onto a bundle.
- `paragraphs_bundles_get_bundle_machine_names()` / `paragraphs_bundles_paragraph_is_managed_bundle()` —
  enumerate the bundles this suite manages (used by preprocess to scope styling).
- `hook_update_N` routines re-import newer fields on upgrade (some submodules, e.g. alert, carry their own
  `_update_fields_from_yml()` helper using `FileStorage` on their `config/optional`).

## Attaching bundles to content

1. Enable the bundle submodules you want.
2. On the host entity (node type, or the suite's **PB Content**/**PB Block**), add a **Paragraphs**
   reference field (entity_reference_revisions) — or reuse an existing one.
3. In the field's settings, allow the bundle types you enabled.
4. Editors then add paragraphs and fill the Content + Display tabs.

## Cloning a bundle to make your own

The submodules are the template. To add a custom bundle:

1. Copy a submodule closest to your need (e.g. `paragraph_bundle_grid`).
2. Rename the module, the `paragraphs.paragraphs_type.<bundle>.yml`, and all `field.*` config in
   `config/optional/` to your new bundle machine name.
3. Copy/rename the `paragraph--<bundle>.html.twig` template (keep the shared style-variable block from
   [../theming/rendering.md](../theming/rendering.md) so Display-tab styling keeps working).
4. Add `dependencies: - paragraphs_bundles:paragraphs_bundles` in the info.yml (plus any field deps).
5. Enable it; the `config/optional` fields provision automatically.

Reuse the base module's `paragraphs_bundles_rgb` / `paragraphs_bundles_range` fields for color/opacity
Display controls (see [../plugins/fields.md](../plugins/fields.md)).
