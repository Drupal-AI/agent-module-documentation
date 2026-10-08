<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three UIkit field formatters

All three live in `src/Plugin/Field/FieldFormatter/`, extend core `Drupal\Core\Field\FormatterBase`
(NOT the image `ImageFormatterBase`), and declare `field_types = {"image", "entity_reference"}`. You
pick one on **Manage Display** for an image field or a media reference field; there is **no admin
route and no config schema** — every setting lives on the formatter instance in the display config.

| Plugin id | Class | Label | Theme hook |
| --- | --- | --- | --- |
| `uikit_lightbox` | `UikitLightbox` | "Uikit lightbox" | `uikit_lightbox` |
| `uikit_slideshow` | `UikitSlideshow` | "Uikit slideshow" | `uikit_slideshow` |
| `uikit_slider` | `UikitSlider` | "Uikit slider" | `uikit_slider` |

## `viewElements()` — media resolution (identical in all three)

```php
if ($items->getItemDefinition()->getDataType() == "field_item:entity_reference") {
  // For each referenced media, swap in its SOURCE field's item list.
  $media = $item->entity;
  $source_field_name = $media->getSource()->getConfiguration()['source_field'];
  $m_items[] = $media->get($source_field_name);
}
```

So on a media reference field the formatter reformats the media **source** field (e.g. the image or
video file on the media type). Each item then becomes a render element:
`['#theme' => 'uikit_<type>', '#item' => $item, '#display_settings' => $this->getSettings()]`.
Note the assumption that a referenced entity is always a media with a `getSource()` — pointing one of
these formatters at a non-media entity_reference field will error.

## `uikit_lightbox` settings (`defaultSettings()` / `settingsForm()`)

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `content.style` | select (image style) | `''` | Image style for the thumbnail shown in the grid. Empty = original. |
| `content.lightbox_style` | select | `''` | Image style for the large image opened in the lightbox. |
| `content.legend` | checkbox | `TRUE` | Show the alt text as a `.thumbnail-caption` under each thumbnail. |
| `nb-items.width_` … `width_@xl` | select | `1,2,3,4,4` | `uk-child-width-1-N{@bp}` grid column class per breakpoint (`''`,`@s`,`@m`,`@l`,`@xl`). Empty option = not applied. |
| `lightbox.animation` | select | `slide` | `slide` / `fade` / `scale`. |
| `lightbox.autoplay` | checkbox | `TRUE` | Lightbox autoplay. |
| `lightbox.autoplay-interval` | number (min 3000, step 1000) | `5000` | Ms between slides. |
| `lightbox.pause-on-hover` | checkbox | `TRUE` | Pause autoplay on hover. |

`settingsSummary()` prints content/lightbox image style, legend, animation, autoplay, interval,
pause-on-hover. (Minor upstream bug: the summary reads `$this->getSetting('lightbox_style')` /
`getSetting('style')` at the top level, which don't exist, so the lightbox-style summary line always
falls to "Original image".)

## `uikit_slideshow` settings

Groups: `content`, `slideshow`, `navigation`, `lightbox`.

- **content**: `style` (image style, default `''`), `legend` (TRUE — overlay caption),
  `caption_background` (`uk-overlay-default|-primary|-secondary`, default NULL),
  `caption_transition` (`uk-transition-*`, default NULL), `caption_position` (`uk-position-*`,
  default NULL), `caption_modifier` (`uk-position-small|-medium|-large`, default NULL),
  `caption_toggle` (FALSE — show legend only on hover).
- **slideshow**: `animation` (`slide|fade|scale|pull|push`, default `slide`), `autoplay` (TRUE),
  `autoplay-interval` (`'6000'`), `pause-on-hover` (TRUE), `finite` (FALSE — disable infinite loop),
  `min-height` (`''`), `max-height` (`''`), `ratio` (textfield, `'16:9'`), `velocity` (`1`).
- **navigation**: `slidenav` (TRUE), `slidenav_outside` (FALSE), `slidenav_big` (FALSE),
  `dotnav` (FALSE), `thumbnav` (FALSE), `thumbnav-style` (image style, `'thumbnail'`),
  `light` (FALSE — add `.uk-light`).
- **lightbox**: `enabled` (FALSE), `style` (image style, `''`), `animation` (`slide`),
  `autoplay` (TRUE), `autoplay-interval` (`5000`), `pause-on-hover` (TRUE). When enabled, each slide
  becomes a `uk-lightbox` link.

## `uikit_slider` settings

Groups: `content`, `slider`, `nb-items`, `navigation`, `lightbox`.

- **content**: `style` (`''`), `gutter` (FALSE — grid gutter between items), `legend` (TRUE), plus
  the same `caption_background` / `caption_transition` / `caption_position` / `caption_modifier` /
  `caption_toggle` overlay controls as slideshow.
- **slider**: `autoplay` (TRUE), `autoplay-interval` (`'7000'`), `center` (FALSE — center active
  slide), `finite` (FALSE), `pause-on-hover` (TRUE), `sets` (FALSE — slide by sets), `velocity` (`1`).
- **nb-items**: `uk-child-width-*` per breakpoint, same as lightbox (defaults `1,2,3,4,4`).
- **navigation**: same keys as slideshow (`slidenav`, `slidenav_outside`, `slidenav_big`, `dotnav`,
  `thumbnav`, `thumbnav-style` = `'thumbnail'`, `light`).
- **lightbox**: same as slideshow (`enabled` FALSE by default).

## How settings become UIkit attributes

The formatter only stashes settings on the render element. The actual `data-uk-lightbox` /
`data-uk-slideshow` / `data-uk-slider` attribute strings are assembled later in
`uikit_image_formatter_preprocess_field()` (see [../theming/theming.md](../theming/theming.md)), which
concatenates each `setting:value;` pair from the relevant settings group into the component attribute,
plus slidenav/dotnav/thumbnav and (for slider/slideshow) lightbox sub-attributes.

## Notes / gotchas

- These extend `FormatterBase`, so unlike core's image formatter they do **not** inherit image-field
  cache-tag/URL handling for free — the item templates and preprocess do it manually
  (`ImageStyle::load()->buildUrl()`, `file_url_generator`).
- No config schema ships (`provides_config_schema` is false; there is no `config/` directory), so the
  formatter settings are not validated against a schema and won't appear in typed-config tooling.
- Selecting a formatter is gated only by the entity's administer-display permission; there is no
  module permission.
