<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type / widget / formatter plugins

The module defines **no plugin types of its own**. It registers three core-plugin instances,
all with the same id `paragraph_view_mode`.

| Kind | id | Class | Extends |
|---|---|---|---|
| FieldType | `paragraph_view_mode` | `ParagraphViewModeItem` | core `StringItem` |
| FieldWidget | `paragraph_view_mode` | `ParagraphViewModeWidget` | core `StringTextfieldWidget` |
| FieldFormatter | `paragraph_view_mode` | `ParagraphViewModeDefaultFormatter` | `text` module's `TextDefaultFormatter` |

Annotations (not attributes) declare them. The field type sets
`category = "manage_display"` — a category defined in
`paragraph_view_mode.field_type_categories.yml` labelled *Manage display* — plus
`default_widget`/`default_formatter` both `paragraph_view_mode`. The classes are essentially
empty subclasses; all behaviour is in the widget.

## Config schema

```yaml
field.storage_settings.paragraph_view_mode:  type: field.storage_settings.string
field.value.paragraph_view_mode:             type: field.value.string
field.formatter.settings.paragraph_view_mode: type: field.formatter.settings.text_default
field.widget.settings.paragraph_view_mode:
  type: field.widget.settings.string_textfield   # plus:
  mapping:
    view_modes:        sequence of string
    default_view_mode: string
    form_mode_bind:    boolean
    apply_to_preview:  boolean
```

## The widget

`ParagraphViewModeWidget::defaultSettings()`:

```php
[
  'view_modes'        => <all view modes available for the bundle>,
  'default_view_mode' => 'default',
  'form_mode_bind'    => TRUE,
  'apply_to_preview'  => FALSE,
]
```

`formElement()` replaces the inherited textfield with `#type => 'select'`, `#required => TRUE`,
options = the ticked view modes (or a single `default => Default` fallback when none are
ticked), default = the stored value or `default_view_mode`.

When `form_mode_bind` is on it also attaches `#ajax` with callback
`ParagraphViewModeWidget::reloadSubform` on the `change` event, wrapping the form in
`<div id="view-mode-paragraph-<paragraph uuid>">`. That AJAX rebuild is what makes
`hook_entity_form_mode_alter()` fire.

`settingsForm()` builds *Available view modes* (checkboxes, AJAX-refreshing the *Default value*
select), *Default value*, *Bind with the form mode*, *Apply to preview mode*.
`settingsSummary()` prints `Available view modes: …`, or *"No view modes enabled, "default"
view mode will be used instead."* when none are ticked.

Option source: `getAvailableViewModes()` calls
`entity_display.repository:getViewModeOptionsByBundle('paragraph', <type>)` when a
`paragraphs_type` is on the current request (i.e. on the Manage form display page), otherwise
`getViewModeOptions('paragraph')`. Only view modes enabled under **Custom display settings** on
the bundle's Manage display tab appear.

## Attaching the field yourself

You normally never create the field manually — use
`\Drupal::service('paragraph_view_mode.storage_manager')->addField($bundle)`. If you must:

```php
FieldStorageConfig::create([
  'entity_type' => 'paragraph',
  'field_name'  => 'paragraph_view_mode',
  'type'        => 'paragraph_view_mode',
])->save();
FieldConfig::create([
  'field_name' => 'paragraph_view_mode',
  'entity_type' => 'paragraph',
  'bundle' => $bundle,
  'label' => 'Paragraph view mode',
])->save();
```

The field name **must** be `paragraph_view_mode`; the matcher looks it up by that exact name.
