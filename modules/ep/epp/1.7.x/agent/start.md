# Entity Prepopulate (epp) — agent index

Prefills a fieldable entity's field on its add/edit form from a **token-enabled YAML template**
stored as a third-party setting on the field config. Applied at the entity level via
`hook_entity_prepare_form()`. No config UI page, no permissions, no plugins, no Drush. Its only
persistent state is two third-party settings on a field: `epp.value` and `epp.on_update`.

- **Set the prepopulate Value / "Also on update" on a field; where it's stored; drush** →
  [configure/field-settings.md](configure/field-settings.md)
- **Mechanism: how/when the value is applied (token resolution, YAML parse, validation)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- No `configure` route; configured on each field's settings form (the "Entity Prepopulate" fieldset).
- Third-party settings on `field.field.<entity>.<bundle>.<field>`:
  `third_party_settings.epp.value` (YAML string with tokens) and `third_party_settings.epp.on_update` (bool).
- Applies only when the entity **is new**, unless `on_update` is TRUE.
- Applies only if **all tokens resolve** and the resulting value **validates**; otherwise skipped.
- Token module is a soft suggestion (adds token browser + more tokens); not required.
