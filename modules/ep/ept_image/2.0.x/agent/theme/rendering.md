<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: templates, hooks, image styles & GLightbox

Hook logic lives in the autowired OOP class `Drupal\ept_image\Hook\EptImageHooks`
(`ept_image.services.yml`); `ept_image.module` keeps thin `#[LegacyHook]` wrappers plus two
procedural helpers.

## Templates

- `templates/paragraph--ept-image--default.html.twig` — the bundle's paragraph template. Builds
  wrapper classes (`ept-paragraph`, `ept-paragraph-image`, plus `greyscale` / `colorful-on-hover`
  when those settings are on), attaches `ept_image/ept_image`, prints an `<h2>` for
  `field_ept_title`, wraps `field_ept_image` in a link (lightbox `<a class="glightbox">` when
  enabled, else the plain `field_ept_image_link`), then renders the remaining fields via
  `content|without(...)`. Ends with `{{ styles|raw }}` — the design `<style>` block produced by
  ept_core's `ept_settings_default` formatter / `GenerateCSS` service.
- `templates/field--paragraph--ept-image--field-ept-image.html.twig` — a copy of core's field
  template, registered as a dedicated theme hook so the image field markup can be themed
  independently.

## Hooks (`EptImageHooks`)

| Hook | Method | Effect |
|---|---|---|
| `hook_preprocess_paragraph` | `preprocessParagraph()` | Calls the two helpers below. |
| `hook_theme` | `theme()` | Registers theme hook `field__paragraph__ept_image__field_ept_image` (base hook `field`). |
| `hook_theme_registry_alter` | `themeRegistryAlter()` | Points that hook at this module's `templates/` dir and copies the `field` preprocess pipeline. |
| `hook_theme_suggestions_field_alter` | (procedural in `.module`) | Adds suggestion `field__paragraph__ept_image__field_ept_image` for `field_ept_image`. |

### `_ept_image_apply_image_style()` (procedural)
Only acts on `ept_image` paragraphs whose `field_ept_image` renders as `image_formatter`. If
`field_ept_settings…['image_style']` is set and not `none`, it overrides `#image_style` on the
rendered image on the fly — so the chosen image style wins over the view display's formatter
setting. (Note: the default view display uses `media_thumbnail`, not `image_formatter`, so this
override applies when the display is switched to an image formatter.)

### `_ept_image_apply_lightbox_image_style()` (procedural)
When `image_lightbox` is on: loads the referenced `Media`, resolves its source field to the `File`,
and sets `show_lightbox = TRUE` plus `lightbox_url` — the file's absolute URL if
`lightbox_image_style` is `none`, otherwise `ImageStyle::buildUrl()` for the chosen style. The
template then renders the `<a class="glightbox" href="{{ lightbox_url }}">` and attaches
`ept_image/ept_image_lightbox`.

## Escaping / output notes

- **Caption in the lightbox link**: `data-glightbox="title: {{ content.field_ept_image_caption|render|striptags|trim }}"`
  — rendered through the field's text format, tags stripped, and placed in an HTML attribute
  (Twig autoescape applies).
- **Wrapper link**: `href="{{ content.field_ept_image_link.0['#url'] }}"` uses the core link
  formatter's built `Url` object; `target`/`rel`/`class` are read from the link's `#options`
  attributes (only populated if a link-attributes widget is configured) and printed in attribute
  context.
- **`{{ styles|raw }}`**: the inline `<style>` string comes from ept_core's `GenerateCSS`, which
  `Html::escape()`s each design value; this module contributes no raw markup of its own.

## Libraries (`ept_image.libraries.yml`)

- `ept_image/ept_image` — `css/ept_image.css`; attached by the paragraph template.
- `ept_image/ept_image_lightbox` — `css/ept_image_lightbox.css`; depends on `glightbox/glightbox`
  and `glightbox/init`; attached only when a lightbox is shown.
