<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Combined image style formatters (combined_image_style_formatters) — agent index

Submodule of **combined_image_style**. Provides two **responsive `<picture>` field formatters** that
build per-breakpoint `srcset` entries from **combined image styles**. Package `Image`. Core
`^10.2 || ^11 || ^12`. **Depends on `drupal:responsive_image`** (`.info.yml`) and, functionally, on
the parent `combined_image_style` module (uses its `CombinedImageStyle` class and the parent's
`combined_image_style_responsive_image` theme hook + Twig template). No permissions, no routes, no
config schema.

## Formatters

Both are defined with the `#[FieldFormatter]` attribute and share
`src/CombinedImageStyleFormatterTrait.php`:

- **`responsive_image_combined_image_style`** — "Responsive image (Combined image style)", for
  `image` fields. Class `Plugin/Field/FieldFormatter/ResponsiveImageFormatter` extends core
  `ImageFormatterBase`. Injects `breakpoint.manager` + `file.mime_type.guesser.extension`.
- **`responsive_media_combined_image_style`** — "Responsive media (Combined image style)", for
  `entity_reference` fields (media). Class `Plugin/Field/FieldFormatter/ResponsiveMediaFormatter`
  extends core `EntityReferenceEntityFormatter`. Also injects `entity.repository`. Its overridden
  `getEntitiesToView()` resolves each referenced media entity's source image field and copies
  alt/width/height/title/`_attributes` onto the item; non-file referenced entities fall back to the
  normal `media` view builder.

## The shared trait (`CombinedImageStyleFormatterTrait`)

- **`defaultSettings()`** — `breakpoint_group` (''), `keyed_styles` ([]), `fallback_image_style`
  (''), `image_loading.attribute` ('lazy').
- **`settingsForm()`** — an AJAX-driven form: pick a **breakpoint group**, then for each numbered
  "Style N" set, pick an image style per breakpoint × multiplier; **Add style / Remove style**
  buttons grow/shrink the number of style sets (state kept in `$form_state->get('styles')`); a
  required **fallback image style**; and an **Image loading** attribute (`lazy`/`eager`). Breakpoint
  ids have `.` replaced with `--` for form-key safety. `settingsSummary()` returns `[]`.
- **`viewElement()`** — the render core. For each breakpoint (reversed) it merges the chosen styles
  across all "Style N" sets per multiplier, and for each multiplier builds a **new in-memory
  `CombinedImageStyle`** (`setSourceUri($file->getFileUri())->setImageStyles($imageStyles)`), takes
  its `buildCombinedUrl()` as one `srcset` candidate (keyed by multiplier × 100) and its MIME type
  via `getDerivativeExtension()`. Each breakpoint becomes a `<source>` `Attribute` (`srcset`,
  `media`, and a single `type` when all candidates share a MIME). Emits
  `#theme => 'combined_image_style_responsive_image'` with `#sources` + an `#image` fallback
  (`#theme => 'image_style'` using `fallback_image_style`), the chosen `loading` attribute, and
  merged cache tags from every combined style.

## Config / usage

No settings form of its own beyond the formatter settings above. Enable the parent module and this
submodule, then choose one of the two formatters on an image or media field's **Manage display**. The
`<picture>` markup comes from the parent module's
`templates/combined-image-style-responsive-image.html.twig`.

Parent module: [../../../../agent/start.md](../../../../agent/start.md).
