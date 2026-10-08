<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering, preprocess and templates

The formatters produce almost no markup themselves — the render pipeline is in
`uikit_image_formatter.module` and `uikit_image_formatter.theme.inc`, and the visible HTML is in
`templates/`. There is **no `.libraries.yml`**: the output is UIkit 3 markup and `data-uk-*`
attributes that do nothing without the theme's UIkit 3 CSS/JS.

## Theme hooks (`uikit_image_formatter_theme()`)

- Per-item render hooks: `uikit_lightbox`, `uikit_slideshow`, `uikit_slider` — variables
  `item` (ImageItem) and `display_settings`; preprocess functions in
  `uikit_image_formatter.theme.inc`; templates `templates/uikit-<type>.html.twig`.
- Field-wrapper hooks: `field__uikit_lightbox`, `field__uikit_slideshow`, `field__uikit_slider` —
  `base hook = field`, templates `templates/field--uikit-<type>.html.twig`. These build the outer
  grid / `uk-slideshow` / `uk-slider` container.

## Template suggestions

`uikit_image_formatter_theme_suggestions_field_alter()` adds, for the three formatters:
`field__<formatter>`, `field__<formatter>__<field_type>`, `field__<formatter>__<field_name>`,
`field__<formatter>__<entity_type>__<bundle>`, `field__<formatter>__<entity_type>__<field_name>`,
`field__<formatter>__<entity_type>__<field_name>__<bundle>`. So you can override per field, per
bundle, etc. (README: to override, copy `field--uikit-lightbox.html.twig` / `-slideshow` / `-slider`
into your theme.)

## `uikit_image_formatter_preprocess_field()` — the real logic

Runs for fields whose `#formatter` is one of the three. Steps:

1. Shortens the name (`uikit_lightbox` → `lightbox`) and copies the formatter settings from
   `element[0]['#display_settings']` into `variables['settings']`.
2. Builds the main component attribute as a Drupal `Attribute`:
   `variables['<type>_attributes']['data-uk-<type>']` = the concatenation of `"<setting>:<value>;"`
   for every entry in `settings['<type>']`.
3. Collects `uk-child-width-*` classes from `settings['nb-items']` into
   `variables['grid_child_width_classes']`.
4. For slideshow/slider: creates `list_attributes` (`uk-<type>-items`), `slidenav_prev_attributes`,
   `slidenav_next_attributes`; appends the caption transition (`clsActivated:…`); builds the
   `thumbnavs` copy (re-pointing each item's content style to the thumbnav image style); and, when
   `settings['lightbox']['enabled']`, folds the lightbox options into
   `list_attributes['data-uk-lightbox']`.
5. For slider: forces `clsActivated:uk-transition-active;` and, when `content.gutter`, adds
   `data-uk-grid` + `uk-grid` to the list.

## Item templates and the caption / lightbox link

- **`uikit-lightbox.html.twig`**: `<a href="{{ path }}"{{ attributes }}>{{ image }}…</a>` where
  `path` is the (styled) large-image URL and `attributes` is `{data-alt, data-caption}` = the caption.
  If `item.alt` and `content.legend`, a `.thumbnail-caption` div prints `{{ item.alt }}`.
- **`field--uikit-lightbox.html.twig`**: a `uk-grid` masonry grid (`data-uk-grid: 'masonry: true'`) of
  the item links; `lightbox_attributes` carries `data-uk-lightbox`.
- **`uikit-slideshow.html.twig`** / **`uikit-slider.html.twig`**: render `{{ image }}` (as
  `uk-cover` for slideshow), wrapping it in a lightbox `<a>` when `display_settings.lightbox.enabled`.
- **`field--uikit-slideshow`/`field--uikit-slider.html.twig`**: build the `<ul class="uk-*-items">`,
  the overlay caption (`<h3>{{ item.content['#item'].title }}</h3>` + `<p>{{ …alt }}</p>`), and the
  optional slidenav / dotnav / thumbnav.

### Caption source

In `theme.inc` the caption is `alt` if present, otherwise `title` (used for the lightbox
`data-alt`/`data-caption`). In the field templates the overlay shows `title` as `<h3>` and `alt` as
`<p>`. All of these are printed through Twig autoescaping, and the `data-*` values are rendered via a
Drupal `Attribute` object, so they are HTML-escaped on output.

## Video / remote-video media handling (lightbox + slideshow)

`template_preprocess_uikit_lightbox()` and `template_preprocess_uikit_slideshow()` special-case media:

- Media bundle `remote_video` or `video`: the poster comes from the media `thumbnail` entity
  (uri/alt/title). For `remote_video` the lightbox `path` is the media's string value (external URL);
  for `video` it is the URL of `field_media_video_file`.
- Slideshow additionally: if the source item is a `video/*` file it renders a `<video … uk-cover>`;
  if the item has no entity it treats the string as a YouTube URL, extracting the 11-char id via a
  regex and rendering a `uk-cover` `<iframe>` (falling back to the raw string when the regex misses).

## Overriding

Copy any `field--uikit-*.html.twig` into your theme and adjust. The important classes/attributes are
already exposed as Twig variables (`slideshow_attributes`, `list_attributes`, `grid_child_width_classes`,
the `settings.*` tree), so most customisation is class tweaking rather than logic changes.
