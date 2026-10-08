<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: templates, theme hook, FlexSlider init & libraries

The module contributes markup through three Twig templates and a single hook; the JS options and the
`{{ styles|raw }}` design block are actually assembled by **ept_core** at view time (this module has
no preprocess of its own).

## Hook (`Drupal\ept_slideshow\Hook\EptSlideshowHooks`)

One implementation, autowired via `ept_slideshow.services.yml`; `ept_slideshow.module` keeps a thin
`#[LegacyHook]` wrapper.

| Hook | Method | Effect |
|---|---|---|
| `hook_theme_registry_alter` | `themeRegistryAlter()` (`src/Hook/EptSlideshowHooks.php:18`) | Registers two dedicated theme entries pointing at this module's `templates/` dir: `paragraph__ept_slideshow_item__default` (base hook `paragraph`) and `field__paragraph__field_ept_slideshow__ept_slideshow` (base hook `field`), copying the base hook's `render element` and preprocess pipeline. |

The wrapper bundle template `paragraph--ept-slideshow--default.html.twig` needs no registration — the
Paragraphs module already provides the `paragraph__ept_slideshow__default` bundle suggestion.

## Templates

- `templates/paragraph--ept-slideshow--default.html.twig` — the wrapper. Builds `ept-paragraph`
  classes, `attach_library('ept_slideshow/flexslider')`, renders the title inside a wrapper element
  chosen from `field_ept_settings…title_options.title_wrapper` (`h1`–`h5`, `none`, or default `h2`),
  optionally `striptags`-filters the title, then prints the remaining fields with
  `content|without('field_ept_settings', 'field_ept_title')`. Ends with `{{ styles|raw }}`.
- `templates/field--paragraph--field-ept-slideshow--ept-slideshow.html.twig` — the field template
  for `field_ept_slideshow`. Adds the wrapper classes **`ept-slideshow-wrapper flexslider`** and
  renders each slide item as `<div class="slides"> … <div class="slide">{{ item.content }}</div>`.
  This `.ept-slideshow-wrapper` element is exactly what the JS calls `.flexslider()` on.
- `templates/paragraph--ept-slideshow-item--default.html.twig` — one slide. When
  `field_ept_slideshow_link` is set, wraps the slide image
  (`content.field_ept_slideshow_slide`) in `<a href="{{ content.field_ept_slideshow_link.0['#url'] }}">`
  and prints title/text; else prints all content. Attaches `core/drupalSettings` and
  `ept_slideshow/flexslider`, ends with `{{ styles|raw }}`.

### `{{ styles|raw }}`

`styles` is set by ept_core's `hook_preprocess_paragraph` (`EptCoreHooks::preprocessParagraph`) to
the string returned by the `ept_core.generate_css` service (`GenerateCSS::generateFromSettings`).
That service builds a `<style>.paragraph-id-<id>{ … }</style>` block from the paragraph's
**design_options** only, and passes each value through `Html::escape()`. The design values come from
the (privileged) editor's Settings tab; no request data reaches this block.

## FlexSlider initialisation

1. At view time, ept_core's `hook_ENTITY_TYPE_view` (`EptCoreHooks::paragraphView`) — because the
   widget stored `pass_options_to_javascript = TRUE` — attaches
   `drupalSettings[<camelBundle>]['paragraph-id-<id>'] = ['paragraphClass' => 'paragraph-id-<id>', 'options' => <ept_settings>]`.
   For the `ept_slideshow` bundle the camelCased key is **`eptSlideshow`**.
2. `js/flexslider/flexslider.js` (`Drupal.behaviors.eptSlideshow`) iterates
   `drupalSettings.eptSlideshow`, finds `.paragraph-id-<id>`, guards against double-init with a
   `flexslider-added` class, maps the stored `options` onto FlexSlider settings (numbers via
   `parseInt`, free-text `animation`/`direction`/`startAt`/`prevText`/`nextText`/`pauseText`/`playText`
   via `Drupal.checkPlain()`), sets `selector: '.slides > .slide'`, then calls
   `.ept-slideshow-wrapper.flexslider(options)`.
3. The FlexSlider engine itself is the vendored `/libraries/flexslider/jquery.flexslider-min.js`
   (from the `levmyshkin/flexslider` composer package), declared in the library below.

## Libraries (`ept_slideshow.libraries.yml`)

`ept_slideshow/flexslider`:
- JS: `/libraries/flexslider/jquery.flexslider-min.js` (minified, external lib) + `js/flexslider/flexslider.js`.
- CSS (component): `/libraries/flexslider/flexslider.css` + `css/flexslider/flexslider.css`.
- Dependencies: `core/drupal`, `core/jquery`, `core/once`, `core/drupalSettings`.

If the FlexSlider library files are missing from `/libraries/flexslider/`, the slider will not
initialise (only Drupal's own `js/flexslider/flexslider.js` loads; `.flexslider()` is undefined).
