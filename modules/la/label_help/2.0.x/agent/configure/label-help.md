# Label Help — configuring help text (UI + storage)

No settings page (`configure: null`). You configure Label Help **per field**.

## In the UI

On any field's edit form (`/admin/structure/types/manage/<bundle>/fields/<field_id>`), Label Help adds
a **"Label help message"** textarea (via `hook_form_field_config_edit_form_alter()`). Whatever you type
is saved when you save the field; clearing it removes the setting.

## Where it is stored

The value is a **third-party setting on the `field_config` entity**:

```
field.field.<entity_type>.<bundle>.<field_name>:
  third_party_settings:
    label_help:
      label_help_description: 'Your help text'
```

Read/write it in code:

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_foo');
$fc->getThirdPartySetting('label_help', 'label_help_description');      // read
$fc->setThirdPartySetting('label_help', 'label_help_description', 'Help');// write
$fc->unsetThirdPartySetting('label_help', 'label_help_description');     // clear
$fc->save();
```

(The entity builder `label_help_form_field_config_edit_form_builder` sets the setting when the textarea
has a value and unsets it when empty.)

## How it is placed on the form

`hook_form_alter()` adds a `#process` callback, `label_help_process_form()`, which for each form child
reads the `#label_help` property (code) or the field's `label_help_description` (UI) and inserts it near
the label. Because widgets differ, it runs a cascade of ~18 "use cases" and injects via `#label_suffix`,
`#field_prefix`, `#description`, or the element `#title`, depending on the widget (containers,
multi-value, fieldsets, checkboxes/radios, details, datetime, link, autocomplete, select lists, custom
elements), with a label-suffix fallback.

## Theming

Help text is rendered through a themeable `label_help` render element (`hook_theme()`), with theme
suggestions and dedicated CSS/templates for **Seven, Claro and Gin** attached automatically based on the
active theme stack (`label_help/seven|claro|gin` libraries).

## Debugging (settings.php)

- `$settings['label_help_debug'] = TRUE;` — annotates each rendered help text with the widget "use case"
  number and placement, so you can see why it landed where it did.
- `$settings['label_help_debug_dump'] = TRUE;` — dumps the element render arrays (may disrupt page
  rendering; expected).

## Config schema note

`config/schema/label_help.schema.yml` declares a `node.type.*.third_party.label_help` mapping; the
actual per-field value used by the module is the `field_config` third-party setting above.
