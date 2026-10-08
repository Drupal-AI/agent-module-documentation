<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping fields / view modes / groups to components

No admin settings page (`configure: null`). Everything is configured on an entity's
*Manage display* and stored in display config. There are three integration points.

## 1. Whole view mode → one component

On *Manage display* the form gains an "SDC Display" section (from
`sdc_display_form_entity_view_display_edit_form_alter()`). Enabling it and choosing a
component makes `sdc_display_entity_view_alter()` replace the entire entity render with that
component. Stored on the `entity_view_display` config entity:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setThirdPartySetting('sdc_display', 'enabled', TRUE);
$vd->setThirdPartySetting('sdc_display', 'component', ['machine_name' => 'olivero:teaser']);
$vd->setThirdPartySetting('sdc_display', 'mappings', [
  'static'  => ['props' => [], 'slots' => []],
  'dynamic' => ['props' => [], 'slots' => []],
]);
$vd->save();
```

Config path: `core.entity_view_display.<entity>.<bundle>.<mode>` →
`third_party_settings.sdc_display` = `{ enabled, component: {machine_name}, mappings }`.
Read back with `$vd->getThirdPartySettings('sdc_display')`.

## 2. Single field formatter → component

Per-field, the formatter's third-party settings form (from
`hook_field_formatter_third_party_settings_form()`) stores the same `sdc_display` bag on the
field's component in the `entity_view_display`; `sdc_display_preprocess_field()` then renders
each field item as `#type => component`, placing the field value into the mapped prop/slot:

```yaml
# core.entity_view_display.node.article.default -> content.field_x.third_party_settings.sdc_display
enabled: true
component: { machine_name: 'mytheme:card' }
mappings:
  static:  { props: {…}, slots: {…} }   # fixed values
  dynamic: { mapped: 'title' }          # which prop/slot the field value feeds
```

## 3. Field group → component

Add a Field Group and pick the **"Single Directory Component"** formatter (id `sdc_display`,
**view** display only). Stored like any field group:

```yaml
# third_party_settings.field_group.<group_name>
format_type: sdc_display
format_settings:
  component: { machine_name: 'mytheme:hero' }
  # + prop/slot mappings for the group's children
```

## Which components appear in the pickers

Controlled by two tags declared in `sdc_display.component_tags.yml` (provided through
`cl_editorial`'s `sdc_tags`): tag a component `sdc_display:field_formatter` to offer it in
the field/field-group picker, and `sdc_display:view_mode` to offer it in the view-mode
picker. Add the tag in the component's `*.component.yml`. (For config introspection the
stored `component.machine_name` is any valid SDC id, e.g. `olivero:teaser`.)
