<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The inline settings widget

## Enabling it

On the host bundle's **Manage form display**, set the registration field's widget to **"Inline entity
form - Settings"** (`inline_entity_form_settings`). The host edit form then embeds the registration
settings sub-form inline. This is a widget for the `registration` field type (the field that makes a
bundle registrable).

Storage — a component in the bundle's `entity_form_display`:

```yaml
content:
  field_registration:
    type: inline_entity_form_settings
    settings:
      form_mode: default
      override_labels: false
      label_singular: ''
      label_plural: ''
      collapsible: false
      collapsed: false
      revision: false
      hide_register_tab: false
```

Set it in code:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.event.default');
$component = $fd->getComponent('field_registration');
$component['type'] = 'inline_entity_form_settings';
$component['settings']['form_mode'] = 'default';
$fd->setComponent('field_registration', $component)->save();
```

## Widget settings (schema `field.widget.settings.inline_entity_form_settings`)

| Setting | Meaning |
|---|---|
| `form_mode` | registration-settings form mode used inline |
| `override_labels`, `label_singular`, `label_plural` | customise the inline section labels |
| `collapsible`, `collapsed` | render as a (collapsed) fieldset |
| `revision` | create a new revision on change |
| `hide_register_tab` | hide the separate Register tab (from the base widget) |

## Behaviour

`RegistrationInlineEntityFormHooks`, `RegistrationElementSubmit`, `RegistrationWidgetSubmit` and the
`RegistrationSettingsInlineForm` inline handler ensure the embedded registration settings validate and
save together with the host entity. Editing the inline settings requires the
`edit registration settings` permission (see [../permissions/permissions.md](../permissions/permissions.md)).
