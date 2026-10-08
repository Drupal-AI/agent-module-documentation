<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Formats — configuration

## Global setting

Route `better_formats.settings` → `/admin/config/content/formats/settings`
(permission `administer filters`). Config `better_formats.settings`:

```yaml
per_field_core: false   # "Use field default"
```

When **true**, Better Formats lets you set a field's default text format through the field's
standard **Default Value** form even when the field value is left empty, and uses that as the
default format for new content in that field.

## Per-field settings (the main surface)

For any `text`, `text_long`, or `text_with_summary` field, the **field config edit form**
gains a "Text Formats" fieldset. Choices are stored as third-party settings on the
`FieldConfig` entity: `field.field.<entity>.<bundle>.<field>.third_party.better_formats`
(schema `field.field.*.*.*.third_party.better_formats`):

```yaml
third_party_settings:
  better_formats:
    allowed_formats_toggle: true          # "Limit allowed text formats"
    allowed_formats:                      # which formats are allowed (keyed by format id)
      basic_html: basic_html
      full_html: '0'                      # unchecked
    default_order_toggle: false           # "Override default order"
    default_order_wrapper:
      formats:                            # per-format weight (tabledrag) for new content
        basic_html: { weight: '-5' }
        full_html: { weight: '0' }
```

Effects at edit-form render (`better_formats_filter_process_format`):

- **allowed_formats_toggle + allowed_formats** → the format selector `#options` are
  intersected with the enabled formats. If only one remains, the selector is hidden; if none
  remain, the field is hidden. If the saved value's format is no longer allowed, the user is
  forced to pick a new one (safely).
- **default_order_toggle + default_order_wrapper.formats** → on **entity create** the options
  are reordered by weight and the first becomes the default (unless `per_field_core` is on).

## Setting per-field allowed formats with Drush

```bash
drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_bf_task");
  $fc->setThirdPartySetting("better_formats", "allowed_formats_toggle", TRUE);
  $fc->setThirdPartySetting("better_formats", "allowed_formats", ["basic_html" => "basic_html"]);
  $fc->save();
'
```

`allowed_formats` is keyed by text-format id with a truthy value to enable it; the module
does `array_filter()` then `array_intersect_key()` against the selector options, so only
enabled ids survive. Enable the global toggle instead with:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("better_formats.settings")->set("per_field_core", TRUE)->save();'
```
