<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UIkit Image Formatter (uikit_image_formatter) — agent index

Three **field formatters** for `image` and media `entity_reference` fields that emit **UIkit 3**
markup and `data-uk-*` attributes: **UIkit Lightbox** (`uikit_lightbox` — a masonry grid of
thumbnails that opens a `uk-lightbox` gallery), **UIkit Slideshow** (`uikit_slideshow` —
`uk-slideshow`) and **UIkit Slider** (`uikit_slider` — `uk-slider`/carousel). Version **8.x-1.13**,
core `^10.1 || ^11`, **no module dependencies**, **no config schema**, no permissions, no routes.

**The value is entirely in the qualifier — this is for sites whose theme already ships UIkit 3.**
The module has **no `.libraries.yml`**: it produces markup and attributes only, and depends on the
theme (the [`uikit`](https://www.drupal.org/project/uikit) base theme, or UIkit 3 you load yourself)
to provide the CSS/JS that makes them interactive. On any other site the output is inert. Nothing in
the dependency graph enforces the presence of UIkit — that is the thing to verify.

## What you'd do → where

- **Choose / configure a formatter on Manage Display; every setting key and default; how
  `viewElements()` resolves media source fields** → [fields/formatters.md](fields/formatters.md)
- **How the markup is built (theme hooks, the `hook_preprocess_field` attribute assembly, template
  suggestions, caption source, video/remote-video handling) and how to override the templates** →
  [theming/theming.md](theming/theming.md)

## Key facts (real machine names)

- Formatter plugins (all `field_types = {image, entity_reference}`, all extend core `FormatterBase`):
  - `uikit_lightbox` — `src/Plugin/Field/FieldFormatter/UikitLightbox.php`, label "Uikit lightbox".
  - `uikit_slideshow` — `UikitSlideshow.php`, label "Uikit slideshow".
  - `uikit_slider` — `UikitSlider.php`, label "Uikit slider".
- Theme hooks (`uikit_image_formatter_theme()`): render hooks `uikit_lightbox`, `uikit_slideshow`,
  `uikit_slider` (preprocess in `uikit_image_formatter.theme.inc`, item templates
  `templates/uikit-*.html.twig`); field wrappers `field__uikit_lightbox` /
  `field__uikit_slideshow` / `field__uikit_slider` (`templates/field--uikit-*.html.twig`,
  `base hook = field`).
- Template suggestions added by `uikit_image_formatter_theme_suggestions_field_alter()`:
  `field__<formatter>`, `field__<formatter>__<field_type>`, `field__<formatter>__<field_name>`,
  `field__<formatter>__<entity_type>__<bundle>`, etc.
- The bulk of the runtime logic is in **`uikit_image_formatter_preprocess_field()`**
  (`uikit_image_formatter.module`): it shortens the formatter name, copies the formatter settings
  into `settings`, and builds the `data-uk-*` component attributes plus slidenav/dotnav/thumbnav and
  lightbox attributes from those settings.
- Caption source: image **alt**, falling back to **title** (`theme.inc`); shown in the slideshow/
  slider overlay as `<h3>` title + `<p>` alt, and as the lightbox `data-alt`/`data-caption`
  attributes. All rendered escaped (Twig autoescape / `Attribute`).
- Media support: when the field is `entity_reference`, `viewElements()` loads each referenced media
  entity's **source field** and formats that. The lightbox/slideshow preprocess special-cases media
  bundles named `video` and `remote_video` (uses the media `thumbnail` for the poster and the video
  file / YouTube URL for playback).
- **No** `configure` route, **no** permissions, **no** drush, **no** config entities or schema. All
  settings live on the field-formatter instance (Manage Display), gated by the entity's
  administer-display permission.
- **No bundled assets.** Requires UIkit 3 from the theme; verify before recommending. Compare a
  framework-independent lightbox (e.g. `baguettebox`) when the site is not on UIkit.
- Live state: enabled on the doc site at 8.x-1.13 (`drush pml` confirms). Rendering not visually
  exercised.
