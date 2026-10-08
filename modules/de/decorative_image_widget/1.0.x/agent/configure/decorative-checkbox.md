# Enable the "Decorative" checkbox on an image field

No configure route and no settings form. You enable it per image field, per form mode, on the
bundle's **Manage form display** page, or directly in the `entity_form_display` config.

## Prerequisite (or the option is hidden)

`DecorativeImageWidgetHelper::getSettingsForm()` returns the checkbox **only when
`$fieldDefinition->getSetting('alt_field_required')` is FALSE**. So on the image field's
storage/field settings you must have **Alt text enabled but NOT required**. If alt is
required, core already forces it and this module's option does not appear.

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`, on the image
field's widget component:

```yaml
content:
  <field_name>:
    type: image_image          # core Image widget (ImageWidget)
    third_party_settings:
      decorative_image_widget:
        use_decorative_checkbox: true
```

Config schema: `field.widget.third_party.decorative_image_widget` — a single boolean
`use_decorative_checkbox`.

## Via the UI

1. Ensure the image field has **Alt field** enabled and **Alt field required** off (field
   settings).
2. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
3. Click the gear/cog on the image field's row.
4. Tick **Force image to be marked decorative if no alt text provided**.
5. **Update**, then **Save**. The widget summary then shows "Decorative checkbox".

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_image');                 // must be an image widget
$c['third_party_settings']['decorative_image_widget']['use_decorative_checkbox'] = TRUE;
$fd->setComponent('field_image', $c)->save();
```

Read back:

```bash
drush cget core.entity_form_display.node.article.default content.field_image
# look for third_party_settings.decorative_image_widget.use_decorative_checkbox: true
```

## What it does at edit time

`DecorativeImageWidgetHelper::process()` (attached via
`hook_field_widget_single_element_form_alter`, D9 uses `hook_field_widget_form_alter`) runs when
the setting is on and the alt field is not `#required`:

- Adds a **Decorative** checkbox (`decorative-checkbox` class) beside the alt field, described
  as "This image is decorative and should be hidden from screen readers." It defaults to
  checked only when editing an image already saved with a file id and empty alt.
- Adds class `alt-textfield` to the alt input and attaches the
  `decorative_image_widget/decorative_image_widget` JS library (keeps checkbox/alt in sync).
- Adds an element validator `validateAltText()`: at real save (skipped during the upload AJAX
  step) if a file is present, alt is empty, and Decorative is unchecked, it errors with
  "You must provide alternative text or indicate the image is decorative."

Stored data is untouched — a decorative image simply persists with `alt = ''`.

## Turn it off

Set `use_decorative_checkbox` to FALSE (or unset the `decorative_image_widget` third-party
settings key) on the component and save.
