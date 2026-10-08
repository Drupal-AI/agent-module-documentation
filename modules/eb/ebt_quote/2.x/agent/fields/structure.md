# The four fields: quote `body`, author, media image, and the `ebt_settings` design options

`ebt_quote` adds **one** widget of its own (`ebt_settings_quote`, see [../plugins/widget.md](../plugins/widget.md))
and no field types. It ships four fields on the `ebt_quote` block bundle: the required rich-text
**`body`** (core `text`), the **`field_ebt_quote_author`** (`text_long`), the media
**`field_ebt_quote_image`** (`entity_reference` → `media`), and **`field_ebt_settings`** whose type,
formatter and schema all belong to `ebt_core`. There is no settings page — all styling is per-block,
entered on the block's **Settings** tab.

## `body` — the quote text

| | |
|---|---|
| Field name | `body` |
| Field type | `text_with_summary` (storage `field.storage.block_content.body`, core `text`) |
| Required | **Yes** (`field.field.block_content.ebt_quote.body.yml`) |
| Label / help | "Quote" / "Quote or Testimonial"; `display_summary: false` |
| Form widget | `text_textarea_with_summary` (`rows: 9`, `summary_rows: 3`, `show_summary: false`) |
| View formatter | `text_default` (label hidden) |

Output security is the standard Drupal text-format model: the `text_default` formatter renders the
stored value through **`check_markup()`** with the **text format** the editor selected, so the allowed
HTML/filters are whatever that format permits. A user can only pick formats their roles are granted, so
raw-HTML injection depends on the site's format/role configuration, not on this module. The template
prints the formatter output (`{{ content.body }}`), not the raw field value.

## `field_ebt_quote_author` — persona / company + role

| | |
|---|---|
| Field name | `field_ebt_quote_author` |
| Field type | `text_long` (storage `field.storage.block_content.field_ebt_quote_author`, shipped here; `cardinality: 1`) |
| Required | No |
| Label / help | "Quote Author" / "Company name, Persona name and job position." |
| Form widget | `text_textarea` (`rows: 5`) |
| View formatter | `text_default` (label hidden) |

Same text-format filtering model as `body` (`check_markup()` via the chosen format). Printed as
`{{ content.field_ebt_quote_author }}`.

## `field_ebt_quote_image` — persona photo or company logo

| | |
|---|---|
| Field name | `field_ebt_quote_image` |
| Field type | `entity_reference` → `media` (storage `field.storage.block_content.field_ebt_quote_image`, shipped here; `cardinality: 1`) |
| Required | No |
| Label / help | "Quote Image" / "Persona photo or Company logo" |
| Allowed bundle | `image` only (`handler: default:media`, `target_bundles: {image: image}`, `auto_create: false`) |
| Form widget | `media_library_widget` |
| View formatter | `media_thumbnail`, label hidden, image style **`quote_image`**, `image_loading: lazy` |

The **`quote_image`** image style (`image.style.quote_image`) has a single `image_scale` effect: width
**530px**, height auto, `upscale: false`. Because the field references existing media entities (no
`auto_create`) with the standard media reference handler, an editor can only pick media they are allowed
to see — no upload path or arbitrary file handling is added by this module.

## `field_ebt_settings` — the shared design options

| | |
|---|---|
| Field name | `field_ebt_settings` |
| Field type | `ebt_settings` (`Drupal\ebt_core\Plugin\Field\FieldType\EbtSettingsItem`) — a serialized `map` column `ebt_settings`; storage owned by `ebt_core` |
| Required | No (label "Block settings") |
| Form widget | **`ebt_settings_quote`** (`Drupal\ebt_quote\Plugin\Field\FieldWidget\EbtSettingsQuoteWidget`) — subclass of `ebt_core`'s `EbtSettingsDefaultWidget` (see [../plugins/widget.md](../plugins/widget.md)) |
| View formatter | `ebt_settings_default` (theme `ebt_settings_default`) |
| Config schema | none in this module (`ebt_core` owns the `ebt_settings` schema) |

The shipped `default_value` keeps `pass_options_to_javascript: false` and empty `design_options`
(margins/borders/padding blank, `border_style: solid`, `border_radius: none`, `container_width: auto`,
etc.), so a plain quote block emits no `drupalSettings` JS options and only inline CSS. The **quote
style** selector added by the custom widget stores its value at
`field_ebt_settings[0]['ebt_settings']['styles']` (default `persona`) — a separate key from
`design_options`, read by the templates.

### Design option keys (all under `design_options`, from `ebt_core`)

Box model — **numeric only** (validated by `EbtSettingsDefaultWidget::validateBoxElement`; non-numeric
is a form error):

- `box1.{margin_top,margin_right,margin_bottom,margin_left}`
- `box1.box2.{border_top,border_right,border_bottom,border_left}`
- `box1.box2.box3.{padding_top,padding_right,padding_bottom,padding_left}`

`other_settings.*`:

| Key | Element | Default | Notes |
|---|---|---|---|
| `border_color` | textfield | — | Hex; validated by `Color::validateHex` (`validateColorElement`). |
| `border_style` | select | `solid` | solid/dashed/dotted/none/hidden/initial/inherit/double/groove/ridge/inset/outset. |
| `border_radius` | select | `none` | `none` or `1px`…`35px` (fixed list). |
| `background_color` | textfield | — | Hex; validated. |
| `background_media` | `media_library` | — | Allowed bundles: media sources `image`, `oembed:video`, `video_file` (only those that exist). |
| `background_image_style` | select | `default` | default(no repeat)/parallax/cover/contain/repeat. |
| `edge_to_edge` | checkbox | `0` | Full-viewport width. |
| `container_width` | select | `auto` | auto/xxsmall/xsmall/small/default/large/xlarge/xxlarge; description links the `ebt_core.settings` form for the pixel values. |

`other_settings.background_image_settings.*`: `background_position` (select; `custom` enables free
text), `background_position_custom` (textfield), `background_size_custom` (textfield), `addOverlay`
(checkbox), `overlayColor` (hex textfield, default `#000000`), `overlayAlpha` (number 0–1, default
`0.3`). The free-text options are not validated in the widget, but
`GenerateCSS::generateFromSettings()` passes them through `Html::escape()` before writing them into the
inline `<style>`, so they cannot break out into markup.

`other_settings.background_video_settings.*` (used only when the background media is a video):
`autoPlay`, `showControls`, `mute`, `startAt`, `opacity`, `addOverlay`, `overlayColor`, `overlayAlpha`,
`loop`, `stopMovieOnBlur`, `playOnlyIfVisible`, `coverImage`, `useOnMobile`, `mobileFallbackImage`.

### Assigning the widget from code

The shipped form display already assigns `ebt_settings_quote`. To (re)assign it — or on another
`ebt_settings` field:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('block_content', 'ebt_quote', 'default')
  ->setComponent('field_ebt_settings', [
    'type' => 'ebt_settings_quote',
    'settings' => [],
    'third_party_settings' => [],
  ])->save();
```

Per-block values are entered on the block's **Settings** tab and saved into the block's
`field_ebt_settings` value (e.g. `ebt_settings.styles = company`,
`design_options.other_settings.background_color = #f5f5f5`,
`design_options.box1.box2.box3.padding_top = 40`).
