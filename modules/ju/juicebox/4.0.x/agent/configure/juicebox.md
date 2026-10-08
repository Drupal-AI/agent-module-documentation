<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Juicebox

Two things to configure: (1) a **display** — attach the formatter to a field or the style
to a View; (2) optional **global settings** at `/admin/config/media/juicebox`.

## 1. Field formatter on an entity display

Attach the `juicebox_formatter` formatter to an image/file/media-reference field in an
`entity_view_display` (Manage Display UI, or config/drush). Settings live under the
component's `settings` key.

```php
// Article "default" view display: render field_gallery as a Juicebox gallery.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');           // create via getViewDisplay() if missing
$vd->setComponent('field_gallery', [
  'type'   => 'juicebox_formatter',
  'label'  => 'hidden',
  'region' => 'content',
  'weight' => 0,
  'settings' => [
    'image_style'    => 'juicebox_medium',        // main image style ('' = original)
    'thumb_style'    => 'juicebox_square_thumb',   // thumbnail style
    'caption_source' => 'alt',                     // '' | alt | title | filename | description
    'title_source'   => 'title',
    // common library options (all optional; sensible defaults exist):
    'jlib_galleryWidth'  => '100%',
    'jlib_galleryHeight' => '100%',
    'incompatible_file_action' => 'show_icon_and_link', // or 'skip'
    'linkurl_target' => '_blank',
  ],
  'third_party_settings' => [],
])->save();
```

Read it back:
```bash
drush config:get core.entity_view_display.node.article.default fields.field_gallery
```

## 2. Views style

In a View, set **Format → "Juicebox Gallery"** (`juicebox` style). Its settings map image
and thumbnail *fields* (and their styles) plus title/caption fields — schema
`views.style.juicebox` (keys: `image_field`, `image_field_style`, `thumb_field`,
`thumb_field_style`, `title_field`, `caption_field`, `show_title`, plus the same `jlib_*`
common options as the formatter).

## 3. Global settings — `juicebox.settings`

Form at `/admin/config/media/juicebox` (route `juicebox.admin_settings`, permission
`administer site configuration`). Keys (`config/install/juicebox.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `apply_markup_filter` | `true` | Filter title/caption output for Juicebox JS compatibility |
| `enable_cors` | `false` | Allow galleries/XML to be embedded remotely |
| `translate_interface` | `false` | Translate the Juicebox JS interface strings |
| `base_languagelist` | `''` | Base string for interface translation |
| `juicebox_multisize_small` | `juicebox_small` | Image style for multi-size "small" mode |
| `juicebox_multisize_medium` | `juicebox_medium` | Image style for multi-size "medium" mode |
| `juicebox_multisize_large` | `juicebox_large` | Image style for multi-size "large" mode |

```bash
drush config:set juicebox.settings enable_cors true -y
```

## Bundled image styles

Installed with the module: `juicebox_small`, `juicebox_medium`, `juicebox_large`,
`juicebox_square_thumb`. Use them (or your own) as the formatter/style image-style values.

## The JavaScript library (required for a live gallery)

Config-level setup verifies fine without it, but to actually *render* a gallery download
Juicebox (Lite free / Pro paid) from https://juicebox.net/download/ and place `juicebox.js`
under `/libraries/juicebox/` (library `juicebox` in `juicebox.libraries.yml`). Without the
JS the formatter still saves and the XML feed still emits — only the client-side gallery
is absent.
