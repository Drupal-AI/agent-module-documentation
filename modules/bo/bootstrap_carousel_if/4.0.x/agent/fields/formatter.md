<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Carousel image field formatter

`src/Plugin/Field/FieldFormatter/BootstrapCarouselImageFormatter.php`

## Plugin

- `@FieldFormatter(id = "bootstrap_carousel_image_formatter", label = "Bootstrap Carousel",
  field_types = { "image" })`.
- Class `BootstrapCarouselImageFormatter extends ImageFormatterBase implements
  ContainerFactoryPluginInterface`. Constructor injects `current_user`, `link_generator`, and
  `entity_type.manager` (used only to load the `image_style` storage).
- Applies to **core image fields**. Intended for a **multi-value** image field so there are
  several slides; a single-value field renders a one-slide carousel with indicators and controls
  suppressed.

## Install / enable

1. `drush en bootstrap_carousel_if` (or via *Extend*). Core `file` + `image` modules must be on;
   `image` ships with core.
2. Ensure the active theme loads **Bootstrap 5** CSS **and JS**. The module bundles no library —
   if only Bootstrap CSS is present, the carousel is styled but does not auto-advance or respond
   to controls.
3. *Structure → Content types → (type) → Manage display*. For a multi-value image field, set the
   format to **Bootstrap Carousel** and click the cog to configure.

## Settings

`defaultSettings()` merges these on top of `ImageFormatterBase::defaultSettings()`:

Exposed in `settingsForm()`:

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `interval` | textfield (required) | `5000` | ms between slides → `data-bs-interval` |
| `pause` | select Yes/No | `0` | Yes → `data-bs-pause="hover"`, else `"false"` |
| `wrap` | select Yes/No | `0` | `data-bs-wrap` true/false |
| `indicators` | select Yes/No | `1` | show dot indicators (auto-off when 1 slide) |
| `controls` | select Yes/No | `1` | show prev/next arrows (auto-off when 1 slide) |
| `image_style` | select | `''` | image style applied to each slide; empty = original |

Stored but **not editable** in the form (fixed defaults): `background` `0`, `background_pos`
`center center`, `keyboard` `0`, `height` `100px`, `width` `100%`. `keyboard` reaches the template
(`data-bs-keyboard`); `background`/`height`/`width` are unused by the shipped template.

`settingsSummary()` prints the chosen image style (or "Original image") and a line summarizing
interval/pause/wrap/indicators/controls. There is no config-schema file, so the display config
stores these under the field-display third-party settings without a typed schema.

## Render pipeline

`viewElements(FieldItemListInterface $items, $langcode)`:

1. `getEntitiesToView($items, $langcode)` — respects image reference access/display; returns
   early (empty render) when there are no files.
2. If an `image_style` is set, loads it and seeds `$cache_tags` from its cache tags; per file it
   merges the file's cache tags (`Cache::mergeTags`).
3. Per delta builds `slides[$delta] = ['title' => <image item Title>, 'image' => ['#theme' =>
   'image_formatter', '#item' => $item, '#item_attributes' => …, '#image_style' => …, '#cache' =>
   ['tags' => $cache_tags]]]`.
4. Returns `$element[0] = ['#theme' => 'bootstrap_carousel', '#slides' => …, '#interval', '#pause',
   '#wrap', '#indicators', '#controls']` where indicators/controls are coerced to `'0'` if
   `count($slides) == 1`.

Caption source: only the image field item's **Title** value populates `slide.title`. The image
**Alt** is carried through `#theme => 'image_formatter'` onto the `<img>` (not into the caption).
The template's `slide.description` branch is dead code — nothing sets it.

## Theme hook + template

- `hook_theme()` registers `bootstrap_carousel` with variables `id, attributes, indicators,
  controls, slides, interval, pause, wrap, keyboard`.
- `templates/bootstrap-carousel.html.twig` emits Bootstrap 5 markup: a `.carousel.slide` wrapper
  with `data-bs-ride="carousel"` and `data-bs-interval/-pause/-wrap/-keyboard`, a random id
  `bs-carousel-{{ random(1000,9999) }}`, `.carousel-indicators` (buttons, only when
  `indicators and slides|length > 1`), `.carousel-inner` with `.carousel-item` (first gets
  `active`), a `.carousel-caption d-none d-md-block` (`<h5>` title, optional `<p>` description),
  and `.carousel-control-prev/next` (only when `controls and slides|length > 1`).
- Uses the **Bootstrap 5** `data-bs-*` API. It emits no `<link>`/`<script>` — Bootstrap must come
  from the theme (or a globally loaded library).

## Operating notes

- To differ per view mode (e.g. thumbnail in teaser, carousel in full), set the formatter only on
  the view displays that should slide.
- Slide order follows the field delta order; reorder images on the entity to reorder slides.
- `interval` is a free-text field with no numeric validation, but it is only settable by users
  with *administer display* rights; Twig auto-escapes it into the `data-bs-interval` attribute.
- Captions render inside `d-none d-md-block`, so they are hidden below the `md` breakpoint by
  Bootstrap's own utility classes.
