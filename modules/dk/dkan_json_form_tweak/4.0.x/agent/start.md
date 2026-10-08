<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN JSON Form Tweaks (dkan_json_form_tweak) — agent index

Presentational usability layer over DKAN's JSON-schema-generated forms. It decorates
`json_form_widget` builder services and adds three opt-in editing aids to the DKAN `data`
bundle form: property **navigation** dropdown, **close_details** collapse button, and
per-value **remove_multivalue** delete checkbox. No routes, no permissions, no Drush.

Requirements / dependencies (info.yml): `dkan:dkan`, `json_form_widget:json_form_widget`;
`core_version_requirement: ^10 || ^11`; composer `drupal/dkan:^4`, `drupal/json_form_widget:*`.
Package: DKAN. License GPL-2.0-or-later. Not covered by security advisory policy.

What it provides:
- Service decorators (`dkan_json_form_tweak.services.yml`):
  - `FormBuilder` decorates `json_form.builder` — injects nav/close/remove UI into the built form.
  - `FieldTypeRouter` decorates `json_form.router` — flags generated elements with `#dkan_field_type_router`.
  - `SchemaUiHandler` decorates `json_form.schema_ui_handler` — applies schema-UI spec to sub-schema props.
  - `ValueHandler` decorates `json_form.value_handler` — strips values whose `remove_item` checkbox is set on save.
- Hooks (`dkan_json_form_tweak.module`): `hook_form_entity_form_display_edit_form_alter` adds the three
  third-party-setting checkboxes to the "Manage form display" form for the `data` bundle; an entity builder
  saves them; `hook_theme()` + two `theme_suggestions` alters register templates and suggestions.
- Config schema (`config/schema`): third-party settings `navigation`, `close_details`, `remove_multivalue`
  under `core.entity_form_display.*.*.*.third_party.dkan_json_form_tweak`.
- Theme hooks `dkan_json_form_navigation`, `dkan_json_form_close_button` + Bootstrap-based twig templates.
- JS libraries `dkan_json_form_navigation`, `dkan_json_form_close_details` (behaviors only, no external deps).

Solution docs:
- [config/settings.md](config/settings.md) — enabling the three tweaks via form-display third-party settings.
- [architecture/decorators.md](architecture/decorators.md) — how the four decorated services build and process the form.
