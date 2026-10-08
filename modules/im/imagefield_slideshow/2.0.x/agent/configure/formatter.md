<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the slideshow field formatter

Formatter id **`imagefield_slideshow_field_formatter`** (class
`ImagefieldSlideshowFieldFormatter`), applicable to `image` fields. Choose it on a bundle's
*Manage display* page (`/admin/structure/types/manage/<bundle>/display`) for the image field,
per view mode. It has no global config; its settings live in the view-display component.

## Settings keys (defaults from `defaultSettings()`)

| Key | Default | Values / meaning |
|---|---|---|
| `imagefield_slideshow_style` | `large` | Image style machine name, or `''` for original image. |
| `imagefield_slideshow_style_effects` | `fade` | `none`, `fade`, `fadeout`, `scrollHorz`, `flipHorz`, `flipVert`, `shuffle`. |
| `imagefield_slideshow_style_pause` | `'false'` | `'true'` / `'false'` (string) — pause on hover. |
| `imagefield_slideshow_prev_next` | `'true'` | Show Prev/Next buttons (only if > 1 image). |
| `imagefield_slideshow_transition_speed` | `100` | 100–1000 step 100, then 2000–10000 step 1000. |
| `imagefield_slideshow_timeout` | `100` | Milliseconds each slide shows (0–1000 step 100, then 2000–10000). |
| `imagefield_slideshow_pager` | `TRUE` | Show default (dot) pager. |
| `imagefield_slideshow_pager_image` | `FALSE` | Show image/thumbnail pager. |
| `imagefield_slideshow_link_image_to` | `''` | `''` (nothing), `content` (the node), or `file`. |

## Storage location

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>
  content:
    <field_name>:
      type: imagefield_slideshow_field_formatter
      label: hidden
      settings:
        imagefield_slideshow_style: large
        imagefield_slideshow_style_effects: scrollHorz
        imagefield_slideshow_timeout: 3000
        ...
```

## Configure via drush / code

```bash
# Set the image field's formatter on the default view display of Article to the slideshow,
# with the scrollHorz effect and a 3000ms timeout:
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_gallery", [
    "type" => "imagefield_slideshow_field_formatter",
    "label" => "hidden",
    "settings" => [
      "imagefield_slideshow_style" => "large",
      "imagefield_slideshow_style_effects" => "scrollHorz",
      "imagefield_slideshow_timeout" => 3000,
    ],
    "region" => "content",
  ])->save();
'
```

## Notes

- The field must allow **multiple values** for the slideshow (prev/next, pagers) to appear;
  with a single image the formatter renders one static picture.
- The formatter attaches the `imagefield_slideshow/imagefield_slideshow` library (jQuery
  Cycle2) and sets `#cache max-age = 0` on its output.
- Not every effect listed in Cycle2 is exposed — only the keys in the table above are
  selectable in this version.
