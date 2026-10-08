<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable "Link to parent entity" on a media image formatter

There is **no settings page** (`configure: null`). You enable the behavior per media bundle,
per view mode, on the media's **Manage display** page (or directly in the `entity_view_display`
config).

## Where the setting is stored

Config entity: `core.entity_view_display.media.<bundle>.<view_mode>` (e.g.
`media.image.default`). Path within it:

```yaml
content:
  <image_field_name>:          # e.g. field_media_image
    type: image                # or responsive_image
    third_party_settings:
      media_parent_entity_link:
        link_to_parent: '1'    # string flag; '1' = on
```

## Constraints on where the checkbox appears

The **"Link to parent entity"** checkbox is added by
`hook_field_formatter_third_party_settings_form()` only when **all** of these hold:

- the display's entity type is **`media`**, and
- the field's type is **`image`**, and
- the chosen formatter's plugin id is in the supported list —
  `InitialSettingsService::getFormatters()`, default **`image`** and **`responsive_image`**.

(To allow more formatters, see the alter hook in
[../api/mechanism.md](../api/mechanism.md).) The checkbox description notes it "will override
the link settings above, otherwise it will have no effect" — i.e. it only does something when
the media actually has a parent.

## Via the UI

1. Go to the media bundle's *Manage display*, e.g. `/admin/structure/media/manage/image/display`.
2. On the image field's row, click the formatter **cog**.
3. Tick **Link to parent entity**, click **Update**, then **Save**.
   The summary then shows "Link to parent entity (if media has a parent)".

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('media.image.default');
$component = $vd->getComponent('field_media_image');   // an image/responsive_image formatter
$component['third_party_settings']['media_parent_entity_link']['link_to_parent'] = '1';
$vd->setComponent('field_media_image', $component)->save();
```

Turn it off by setting it to `'0'` or unsetting the `media_parent_entity_link` third-party key.

## Read it back

```bash
drush cget core.entity_view_display.media.image.default content.field_media_image
# look for third_party_settings.media_parent_entity_link.link_to_parent
```
