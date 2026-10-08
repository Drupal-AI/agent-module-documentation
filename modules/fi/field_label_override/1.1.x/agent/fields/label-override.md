# Overriding a field label per view display

`field_label_override` has no config UI of its own. It hooks the core **Manage display** form
(`entity_view_display_edit_form`) and stores overrides inside each display component's
`third_party_settings`. Everything is in `field_label_override.module`.

## The extra Label options (form alter)

`field_label_override_form_entity_view_display_edit_form_alter()` (`.module:29`) walks
`$form['fields']` and, for every field row whose `label` element is a select (`#options` set),
appends three options to the Label dropdown (`.module:42-47`):

| Value | Visible option |
|---|---|
| `above_overridden` | Above (Overridden) |
| `inline_overridden` | Inline (Overridden) |
| `visually_hidden_overridden` | - Visually Hidden (Overridden) - |

The three values mirror core's own `above` / `inline` / `visually_hidden` label positions with an
`_overridden` suffix. When a field's saved Label value is one of the three, the alter inserts a
`label_override_container` right after the Label cell (`.module:61-81`) holding:

- `label_override` — textfield, `#size` 20, `#maxlength` 255, default read from stored config.
- `preserve_label` — checkbox, default read from stored config.

A "Label Override" column header is added, fields without an override get their Label cell widened to
two columns, and the custom submit `field_label_override_form_submit` is spliced into the submit
handlers — but only if at least one field on the form uses an overridden option (`.module:92-107`).

## Where the value is stored (submit)

`field_label_override_form_submit()` (`.module:119`) gets the display entity from
`$form_state->getBuildInfo()['callback_object']->getEntity()`. For each field whose Label value ends
with `_overridden` it writes third-party settings on the component (`.module:127-135`):

```php
$component['third_party_settings']['field_label_override'] = [
  'label_override'  => $field_config['label_override_container']['label_override'] ?: NULL,
  'preserve_label'  => !empty($field_config['label_override_container']['preserve_label']) ?: FALSE,
];
$entity_view_display->setComponent($field_name, $component);
```

If a field no longer uses an overridden option, any existing `field_label_override` third-party
settings are removed (`.module:137-140`).

Config schema `core.entity_view_display.*.*.*.content.*.third_party.field_label_override`
(`config/schema/field_label_override.entity_display.schema.yml`): `label_override` (string),
`preserve_label` (boolean). Stored on the `entity_view_display` config entity, so overrides export
with configuration and are per view mode.

## How it renders (preprocess)

`hook_preprocess_field()` (`.module:149`) reads
`$variables['element']['#third_party_settings']['field_label_override']`:

- **preserve_label off (default):** `$variables['label']` is replaced by `label_override` — the field
  template shows the custom label in place of the original.
- **preserve_label on:** `label` is left untouched and the custom text is exposed as a **new**
  `$variables['label_override']` variable. The original label still renders unless the theme's
  `field.html.twig` is overridden to use `label_override`.

`label` is set to the plain override string; core's `field.html.twig` prints it with `{{ label }}`,
so Twig auto-escaping applies. Only users who can edit the entity's Manage display can set the value.

## Set it from code

Overrides are ordinary third-party settings on the view display, so you can set them without the UI:

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'teaser');
$component = $display->getComponent('body');
$component['label'] = 'above_overridden';
$component['third_party_settings']['field_label_override'] = [
  'label_override' => 'Short description',
  'preserve_label' => FALSE,
];
$display->setComponent('body', $component)->save();
```

Keep the component's existing `type` / `settings`; the module only reads the `label` value (it must
end in `_overridden`) and the `field_label_override` third-party settings.
