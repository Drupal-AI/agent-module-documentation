<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DS field template `ui_pattern_ds_component`

## Install & enable

```bash
composer require drupal/ui_patterns_ds
drush en ui_patterns_ds -y
```

Pulls in the required stack: `ui_patterns` + `ui_patterns_layouts` (`^2.0`) and `ds`/`ds_extras`
(`^3.28`). No config to import, no permissions of its own, no Drush commands, no submodules.

## Enable it on a field

The plugin is `Component` in `src/Plugin/DsFieldTemplate/Component.php`, declared with
`#[DsFieldTemplate(id: 'ui_pattern_ds_component', title: 'FIeld template for UI pattern', theme: 'component')]`
(the label typo "FIeld" is verbatim in source). It extends DS's `DsFieldTemplateBase` and uses
`ComponentFormBuilderTrait` from `ui_patterns`.

UI path: *Structure → (entity type) → (bundle) → Manage display* → click a field's **gear** →
set **Field template** to **"FIeld template for UI pattern"**. The gear form then shows the UI
Patterns component picker (component id + per-prop/per-slot sources) rendered by
`Component::alterForm()`.

`alterForm()` builds a `FormState`, seeds two contexts and merges the component form in:

- `ui_patterns_ds` — a `string` context holding the field name currently being edited, from
  `getCurrentField()`.
- `entity` — an `EntityContext` from `getEntity()` (DS base), when available.

`getCurrentField()` reads the AJAX POST (`request_stack`): it scans `fields[*]` for the one whose
`settings_edit_form.third_party_settings.ds.ft.id == 'ui_pattern_ds_component'`, falling back to the
`_triggering_element_name` (stripping `_plugin_settings_edit`). This only runs while building the
Manage-display settings form, so it can rely on request POST; the real-render path (see the source
doc) supplies the field name differently.

`defaultConfiguration()` returns `getComponentFormDefault()` (the trait's default component config).

## Stored configuration & schema

DS stores the chosen component under the field's third-party `ds.ft` settings on the view display
config entity (`core.entity_view_display.<entity>.<bundle>.<mode>`). The settings shape is the
standard UI Patterns component config.

`config/schema/ui_patterns_ds.schema.yml`:

```yaml
ds.field_template.ui_pattern_ds_component:
  type: ui_patterns_component        # reuses ui_patterns' component schema
  label: 'Component field template settings'

ui_patterns_source.ds_field:
  type: mapping                      # the ds_field source has no settings
  label: 'Source: DS field'
  mapping: {  }
```

There is a working config fixture at
`tests/fixtures/config/core.entity_view_display.node.page.default.ds_field_template.yml` showing a
node "page" display whose field uses this template — a useful reference for a config export.

## Components used as DS *layouts*

Separately from field templates, when a UI Patterns component is used as a **DS layout**, DS
resolves its layout settings to `layout_plugin.settings.ds.*`, which lacks the `ui_patterns` key
that `ui_patterns_layouts` adds to `layout_plugin.settings.*`. `ui_patterns_ds_config_schema_info_alter()`
patches this: if `layout_plugin.settings.ds.*` exists, it adds a `ui_patterns` mapping of type
`ui_patterns_component` so the stored layout component config validates. Fixture:
`tests/fixtures/config/core.entity_view_display.node.page.default.ds_component_layout.yml`.

## Notes

- Alpha release (1.0.0-alpha3) of a rendering integration — pin and test against your exact DS and
  UI Patterns versions.
- The field template only wraps the *field*; DS still owns field ordering, regions and the entity
  wrapper.
