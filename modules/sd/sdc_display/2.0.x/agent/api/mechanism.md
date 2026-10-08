<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render mechanism

SDC Display is entirely hook-driven; it defines no plugin manager of its own. It reads
`third_party_settings.sdc_display` and swaps normal field/entity render arrays for
`#type => component` render elements.

## Config-form hooks (build the "SDC Display" UI)

- `sdc_display_field_formatter_third_party_settings_form()` — adds the SDC mapping controls
  to a single field's formatter settings (uses `cl_editorial.form_generator` +
  `FieldFormatterMappingsSettings`).
- `sdc_display_form_entity_view_display_edit_form_alter()` — adds the whole-view-mode SDC
  controls (`ViewModeMappingsSettings`), prepending its `::submit` handler.
- The field-group formatter `SingleDirectoryComponent` (id `sdc_display`) provides the group
  variant (`FieldGroupMappingsSettings`).

## Render hooks (produce the component)

- `sdc_display_preprocess_field()` — when a field's `sdc_display.enabled` is true, finds the
  component (`plugin.manager.sdc`), builds props from `mappings.static.props`, slots from
  `mappings.static.slots` (as `processed_text`), determines whether the `mappings.dynamic.mapped`
  input is a prop or slot (`cl_editorial\Util::isPropOrSlot`), injects the field item's
  content there, and replaces each item's `content` with
  `['#type' => 'component', '#component' => $id, '#props' => …, '#slots' => …]`.
- `sdc_display_entity_view_alter()` — when the **display's** `sdc_display.enabled` is true and
  a `component.machine_name` is set, replaces the whole `$build` with a single
  `#type => component`. Prop values come from `Util::computePropValues()` (dynamic overrides
  static) and slots from `Util::computeSlotValues()`; it also injects `id`, `entity_type`,
  and `bundle` props automatically. Layout Builder-enabled displays are skipped.

## `third_party_settings.sdc_display` shape

```yaml
enabled: true
component: { machine_name: 'provider:component' }
mappings:
  static:  { props: { <propName>: <value>, … }, slots: { <slotName>: { value, format } } }
  dynamic: { mapped: <prop_or_slot_name> }   # field/field-group value feeds this input
```

## Component tags

`sdc_display.component_tags.yml` declares `sdc_display:field_formatter` and
`sdc_display:view_mode` (surfaced by `cl_editorial`/`sdc_tags`). A component is offered in a
picker only if it carries the matching tag in its `*.component.yml`. This is a filtering
convention, not a Drupal plugin type — `provides_plugin_types` is empty.
