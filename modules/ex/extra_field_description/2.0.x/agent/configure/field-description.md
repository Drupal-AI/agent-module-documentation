<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an extra (above-field) description

No global page. Configure per field on **Manage form display**:
`/admin/structure/types/manage/<bundle>/form-display` (or the equivalent for any entity type / form mode).

1. Open the field's widget settings (the gear/cog).
2. Fill in **Extra description settings → Extra description** (a textarea). This element only appears if the current user has the `administer field prefix` permission and the field is **not** a base field.
3. Save the form display.

The text renders as a prefix **above** the widget on the entity add/edit form.

## Where it is stored
```
core.entity_form_display.<entity_type>.<bundle>.<form_mode>:
  content:
    <field_name>:
      third_party_settings:
        extra_field_description:
          extra_description:
            over_description: "…your text…"
```

## Set it with Drush
```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$c = $fd->getComponent('field_myfield');
$c['third_party_settings']['extra_field_description']['extra_description']['over_description'] =
  'Upload a <strong>square</strong> image.';
$fd->setComponent('field_myfield', $c)->save();
```

## Rendering & placement
`hook_field_widget_single_element_form_alter` injects the value as `#field_prefix` wrapped in `<div class="extra-description">…</div>`:
- `datetime` / `datelist` value elements → prefix on the whole element (`$element['#field_prefix']`).
- entity-reference (`target_id`) → prefix on the `target_id` element.
- otherwise → prefix on `$element['value']` (or the element root).

## Permission & sanitization caveat
- `administer field prefix` (title "Administer extra description") gates the settings UI. It is **not** marked `restrict access: true`, but reaching the widget-settings form also requires core form-display admin (`administer <entity> form display`, which *is* restricted).
- The stored `over_description` is emitted as **raw markup** — it is not passed through a text-format filter on output. The settings form only *labels* the allowed HTML tags (`FieldFilteredMarkup::displayAllowedTags()`); it does not enforce them. Treat the value as trusted admin-authored HTML.

## Styling
Library `extra_field_description/extra_field_description_css` (`css/efd.css`) styles `.extra-description` (muted grey, smaller text) and is attached globally via `hook_page_attachments`.
