# Configure the Multiselect widget

## Attach it to a field

Multiselect is a **field widget**, selected per field on the bundle's **Manage form display**
page (e.g. `/admin/structure/types/manage/article/form-display`). It is offered for fields of type
`list_string`, `list_float`, `list_integer`, and `entity_reference` (the widget's `field_types`).
Set the widget and Save; in the `entity_form_display` config the field's component becomes:

```yaml
content:
  field_colors:
    type: multiselect
    weight: 5
    region: content
    settings:
      size: 60          # inherited from OptionsWidgetBase; rows/size hint
    third_party_settings: {  }
```

Set it programmatically:

```php
\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_colors', ['type' => 'multiselect', 'region' => 'content'])
  ->save();
```

The widget has **no per-field settings form** of its own beyond core's `size`. It renders two
`<select multiple>` boxes (Available / Selected) with Add/Remove buttons; a `#multiple` select is
only shown when the field has more than one allowed option.

## The one global setting: select-box width

Admin form route `multiselect.admin_settings` → `/admin/config/content/multiselect` (permission:
`administer site configuration`). The only field is **Width of Select Boxes (in pixels)**, stored in
the config object `multiselect.settings` at nested key `multiselect.widths` (integer, default `250`):

```yaml
# multiselect.settings
multiselect:
  widths: 250
```

```bash
drush config:get multiselect.settings multiselect.widths
drush config:set multiselect.settings multiselect.widths 400 -y
```

The value is attached to every page as `drupalSettings.multiselect.widths`
(`hook_page_attachments`) and applied to the boxes by the JS.
