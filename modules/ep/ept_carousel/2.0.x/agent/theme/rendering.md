<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: templates, hooks, Tiny Slider init & libraries

The module contributes markup through three Twig templates and two hooks; the JS options and the
`{{ styles|raw }}` design block are actually assembled by **ept_core** at view time (this module has
only one small preprocess of its own, for the slide image style).

## Hooks

### `Drupal\ept_carousel\Hook\EptCarouselHooks::themeRegistryAlter()`

Autowired via `ept_carousel.services.yml`; `ept_carousel.module` keeps a thin `#[LegacyHook]`
wrapper (`ept_carousel_theme_registry_alter`).

| Hook | Method | Effect |
|---|---|---|
| `hook_theme_registry_alter` | `themeRegistryAlter()` (`src/Hook/EptCarouselHooks.php:18`) | Registers two dedicated theme entries pointing at this module's `templates/` dir: `paragraph__ept_carousel_item__default` (base hook `paragraph`) and `field__paragraph__field_ept_carousel__ept_carousel` (base hook `field`), copying the base hook's `render element` and preprocess pipeline. |

The wrapper bundle template `paragraph--ept-carousel--default.html.twig` needs no registration —
ept_core's own `theme_registry_alter` already registers `paragraph__ept_carousel__default` for every
enabled `ept_*` module.

### `ept_carousel_preprocess_paragraph()` (plain function in `ept_carousel.module`)

Runs on every paragraph, acts only on the **`ept_carousel_item`** bundle. It reads the parent
carousel's `field_ept_settings…ept_settings['image_size']` and, if set, overrides the slide image's
`#image_style`:

```php
$variables['content']['field_ept_carousel_image'][0]['#image_style'] = $ept_settings['image_size'];
```

So the per-carousel **Image Size** option ([../configure/settings.md](../configure/settings.md))
wins over the item view display's empty `image_style`. Guards: it bails if the parent is missing, has
no `field_ept_settings`, no `image_size`, or the image render array has no `#image_style` key.

## Templates

- `templates/paragraph--ept-carousel--default.html.twig` — the wrapper. Builds `ept-paragraph`
  classes including `ept-carousel-<styles>` (from `field_ept_settings…ept_settings.styles`), attaches
  `ept_carousel/basic` when `styles == 'basic'` and always `ept_carousel/tiny_slider`, renders the
  title inside a wrapper element chosen from `field_ept_settings…title_options.title_wrapper`
  (`h1`–`h5`, `none`, or default `h2`), optionally `striptags`-filters the title (allowing
  `<span><br><i><img><svg>`), then prints the remaining fields with
  `content|without('field_ept_settings', 'field_ept_title')`. Ends with `{{ styles|raw }}`.
- `templates/field--paragraph--field-ept-carousel--ept-carousel.html.twig` — the field template for
  `field_ept_carousel`. Adds wrapper classes **`tiny-slider`** and the container
  `<div class="ept-carousel-wrapper slides">` with one `<div>` per slide, plus a
  `<div class="ept-carousel-controls">` holding `.ept-carousel-prev` / `.ept-carousel-next`. This
  `.ept-carousel-wrapper` element is exactly what the JS calls `tns()` on.
- `templates/paragraph--ept-carousel-item--default.html.twig` — one slide. When
  `field_ept_carousel_item_link` renders, it wraps the slide image in an `<a>` — **but the href is
  built from `content.field_ept_slideshow_link.0['#url']`**, a leftover copied from `ept_slideshow`
  that does not exist on this bundle, so the href resolves empty; the real link field is
  `field_ept_carousel_item_link`. Attaches `core/drupalSettings` and `ept_carousel/tiny_slider`.

### `{{ styles|raw }}`

`styles` is set by ept_core's `hook_preprocess_paragraph` (`EptCoreHooks::preprocessParagraph`) to
the string returned by the `ept_core.generate_css` service (`GenerateCSS::generateFromSettings`).
That service builds a `<style>.paragraph-id-<id>{ … }</style>` block from the paragraph's
**design_options** only, and passes each value through `Html::escape()`. The design values come from
the (privileged) editor's Settings tab; no request data reaches this block.

## Tiny Slider initialisation

1. At view time, ept_core's `hook_ENTITY_TYPE_view` (`EptCoreHooks::paragraphView`) — because the
   widget stored `pass_options_to_javascript = TRUE` on the wrapper — attaches
   `drupalSettings.eptCarousel['paragraph-id-<id>'] = ['paragraphClass' => 'paragraph-id-<id>', 'options' => <ept_settings>]`.
   The bundle key is camel-cased, so `ept_carousel` → **`eptCarousel`**.
2. `js/tiny-slider/tiny-slider.js` (`Drupal.behaviors.eptCarousel`) iterates
   `drupalSettings.eptCarousel`, finds `.paragraph-id-<id>`, guards against double-init with a
   `tiny-slider-added` class, then builds an `options` object: `container` =
   `.paragraph-id-<id> .ept-carousel-wrapper`, `prevButton`/`nextButton` = the `.ept-carousel-prev` /
   `.ept-carousel-next` controls, numeric options via `parseInt`, boolean options mapped from `1/0`,
   and free-text options (`mode`, `axis`, `preventScrollOnTouch`, `nested`, `nonce`,
   `controlsPosition`, `controlsText`, `navPosition`, `autoplayPosition`, `autoplayDirection`,
   `autoplayText`, `autoplayButton`) via `Drupal.checkPlain()`. Finally calls `tns(options)`.
3. The Tiny Slider engine itself is the vendored `/libraries/tiny-slider/dist/min/tiny-slider.js`
   (from the `levmyshkin/tiny-slider` composer package), declared in the library below.

## Libraries (`ept_carousel.libraries.yml`)

- `ept_carousel/tiny_slider`:
  - JS: `/libraries/tiny-slider/dist/min/tiny-slider.js` (minified, external lib) +
    `js/tiny-slider/tiny-slider.js`.
  - CSS (component): `/libraries/tiny-slider/dist/tiny-slider.css`.
  - Dependencies: `core/drupal`, `core/jquery`, `core/once`, `core/drupalSettings`.
- `ept_carousel/basic`: CSS `css/basic/basic.css` (the `.ept-carousel-basic` nav/arrow styling).

If the Tiny Slider library files are missing from `/libraries/tiny-slider/`, the slider will not
initialise (only Drupal's own `js/tiny-slider/tiny-slider.js` loads; `tns()` is undefined).
