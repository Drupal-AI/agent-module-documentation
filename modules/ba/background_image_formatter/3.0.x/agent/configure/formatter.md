<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Background Image formatter on a field

No settings page — you select the formatter on the field's *Manage display* and set its
options, or write the `entity_view_display` config directly.

## The two formatters

| Formatter id | Field type | Base class |
|---|---|---|
| `background_image_formatter` | `image` | core `ImageFormatter` |
| `background_media_image_formatter` | `entity_reference` **targeting media** | `EntityReferenceEntityFormatter` |

Both are labelled "Background Image". The media one only applies when the reference target
type is `media` (`isApplicable()` checks `target_type == 'media'`) and reads the referenced
media entity's `thumbnail` image.

## Settings (identical for both)

| Setting | Type / values | Meaning |
|---|---|---|
| `image_style` | image style machine name, or `''` | Derivative to use; empty = original image. |
| `background_image_output_type` | `inline` \| `css` | `inline` → a div with a `style` attribute; `css` → a `<style>` rule injected into `<head>`. |
| `background_image_selector` | string | CSS selector/class. In inline mode `_<entity id>` is appended so each item is unique. |
| `background_image_link` | boolean | (inline only) wrap the div in a link to the host entity. |
| `background_image_link_custom` | string | (inline only) custom link URL; supports tokens when the Token module is enabled. Empty = the entity's canonical URL. |

## Via the UI

1. *Structure → Content types → <type> → Manage display*
   (`/admin/structure/types/manage/<bundle>/display`).
2. On the image (or media reference) field's row, set **Format** to **Background Image**.
3. Click the gear and choose the image style, output type (inline/CSS), CSS selector, and
   optional link. **Update**, then **Save**.

## Via config (scriptable)

The formatter is a component of the view display config
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_hero_image', [
  'type' => 'background_image_formatter',
  'label' => 'hidden',
  'settings' => [
    'image_style' => 'large',
    'background_image_output_type' => 'css',    // or 'inline'
    'background_image_selector' => '.hero',
    'background_image_link' => FALSE,
    'background_image_link_custom' => '',
  ],
  'weight' => 0,
  'region' => 'content',
])->save();
```

Read it back:

```bash
drush cget core.entity_view_display.node.article.default content.field_hero_image
# type: background_image_formatter
# settings: { image_style: large, background_image_output_type: css, background_image_selector: .hero, ... }
```

## Output

- **inline**: renders the `background_image_formatter_inline` theme —
  `<div class="<selector>_<id>" style="background-image:url('<url>');">` (optionally wrapped in
  an `<a>`). See [../theming/template.md](../theming/template.md).
- **css**: adds `<style><selector> {background-image: url("<url>");}</style>` to `html_head`.
