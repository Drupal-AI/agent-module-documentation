<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Make a field read-only on the edit form

The module has **no configure route** (`configure: null`) and no admin settings page. You
enable it per field, per form mode, on the entity's **Manage form display** page, or
directly in the `entity_form_display` config — the same shape as any other field widget.

## What it does

Assigning the `readonly_field_widget` widget to a field stops it from rendering an
editable input. Instead, at form-build time the widget calls the entity view builder and
renders the field using a **formatter** — chosen with the widget's own `formatter_type`
setting — exactly as it would appear when viewing the entity. There is no separate
"configure" page for the widget itself; its behavior is entirely controlled by the widget
`settings` stored on the form-display component, set through the normal *Manage form
display* widget-settings (gear icon) form.

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: readonly_field_widget
    settings:
      label: above                # above | inline | hidden | visually_hidden
      formatter_type: string       # the field FORMATTER plugin id that renders the value
      formatter_settings:
        string: {}                 # that formatter's own settings, keyed by formatter id
      show_description: false
      error_validation: false
```

- `formatter_type` — the field formatter plugin id used to render the read-only value
  (must be applicable to the field's type, e.g. `string`/`basic_string` for a `string`
  field, `text_default` for a formatted text field, `image` for an image field, etc.).
  This is how you choose *which* formatter renders the value — there's no separate
  formatter-picker route, it's a `select` in the widget settings form driven by
  `FormatterPluginManager::getOptions()` for the field's type.
- `formatter_settings` — a keyed sequence holding that formatter's own settings (e.g. an
  image style, a number format), keyed by the formatter's plugin id.
- `show_description` — repeats the field's admin-configured description under the
  read-only markup.
- `error_validation` — if true, validation errors on the field are still flagged even
  though the widget isn't directly editable (by default a read-only widget suppresses
  them).

The widget applies to nearly all field types: `readonly_field_widget_field_widget_info_alter()`
merges in the field types of every registered field formatter, so it shows up as an
option for any field with at least one formatter. Note it only renders anything when the
field actually has a value (empty items produce no output), and it explicitly refuses to
be useful as a *default value* widget (it shows a status message telling you to switch to
an editable widget there instead).

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. Article:
   `/admin/structure/types/manage/article/form-display`).
2. Change the field's widget dropdown to **Readonly**.
3. Click the gear/cog on that field's row to open its settings.
4. Pick **Format** (the formatter), **Label** position, and optionally **Show
   Description** / **Error Validation**.
5. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_example', [
  'type' => 'readonly_field_widget',
  'weight' => 10,
  'region' => 'content',
  'settings' => [
    'label' => 'above',
    'formatter_type' => 'string',
    'formatter_settings' => [],
    'show_description' => FALSE,
    'error_validation' => FALSE,
  ],
])->save();
```

To revert a field to a normal editable widget, `setComponent()` it with that field type's
usual widget (e.g. `string_textfield`) instead.

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_example
# look for:  type: readonly_field_widget
#            settings.formatter_type: <formatter plugin id>
```

Or in PHP: `$fd->getComponent('field_example')['type']` and
`$fd->getComponent('field_example')['settings']['formatter_type']`.

## Config schema

The module ships `field.widget.settings.readonly_field_widget` with `label` (string),
`formatter_type` (string), `formatter_settings` (a sequence of
`field.formatter.settings.[%key]`, i.e. each registered formatter's own schema),
`show_description` (boolean), and `error_validation` (boolean).
