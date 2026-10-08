<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Responsive thumbnail" formatter

No admin settings page (`configure: null`, no permission of its own). It is set per field, per
view mode, on the entity's **Manage display** screen — same place any other formatter is
chosen — or directly in the `entity_view_display` config.

## Applicability

The formatter is registered for `field_types: entity_reference`, but
`MediaResponsiveThumbnailFormatter::isApplicable()` only returns `TRUE` when the field
storage's `target_type` setting is `media`. So it only ever shows up as a Format option on an
entity-reference field pointing at Media entities — never on a plain entity-reference field to
nodes, users, taxonomy terms, etc.

## Where the setting is stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`

```yaml
content:
  <field_name>:
    type: media_responsive_thumbnail
    label: hidden          # or 'above' / 'inline' / etc.
    settings:
      responsive_image_style: <machine_name_of_a_responsive_image_style>
      image_link: ''        # '' (no link) | 'content' | 'media'
      image_loading:
        attribute: lazy      # 'lazy' | 'eager'
    third_party_settings: {}
```

Schema: `field.formatter.settings.media_responsive_thumbnail` (in
`config/schema/media_responsive_thumbnail.schema.yml`) simply reuses
`field.formatter.settings.responsive_image` — there are no formatter-specific settings beyond
what core's Responsive Image formatter already defines.

## Settings

| Key | Default | Meaning |
|---|---|---|
| `responsive_image_style` | `''` | Machine name of a `responsive_image_style` config entity (`/admin/config/media/responsive-image-style`) used to render the referenced media's image |
| `image_link` | `''` | What the rendered image links to: empty = nothing, `content` = the entity that has this field, `media` = the media item's own canonical page |
| `image_loading.attribute` | `lazy` | `loading` attribute on the rendered `<img>`: `lazy` or `eager` |

Note: the settings **form** (inherited unmodified from `ResponsiveImageFormatter`) offers
`image_link` options "Content" / "File", but this module's `getMediaThumbnailUrl()` only
recognizes `content` and `media` — picking "File" in the UI silently produces no link.

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/media/manage/image/display`
   for a media type's own display, or the referencing entity's display, e.g.
   `/admin/structure/types/manage/<content_type>/display`).
2. Set the Media reference field's Format to **Responsive thumbnail**.
3. Open the gear/settings icon: choose a **Responsive image style**, an **Image link**
   destination, and the lazy-loading attribute.
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$display = \Drupal::entityTypeManager()
  ->getStorage('entity_view_display')
  ->load('node.article.default');
$display->setComponent('field_hero_media', [
  'type' => 'media_responsive_thumbnail',
  'label' => 'hidden',
  'settings' => [
    'responsive_image_style' => 'wide',
    'image_link' => 'content',
    'image_loading' => ['attribute' => 'lazy'],
  ],
  'third_party_settings' => [],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_hero_media
# look for type: media_responsive_thumbnail and settings.responsive_image_style
```

Or in PHP:
`$display->getComponent('field_hero_media')['settings']['responsive_image_style']`.
