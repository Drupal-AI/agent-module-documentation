<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Slick Slider — bundles, fields, the Slick-options widget, and rendering

## Install / enable
`drush en ept_slick_slider -y` (pulls `ept_core` + `paragraphs`). Composer also requires
`levmyshkin/slick` — the Slick library must live at `/libraries/slick/slick/` (`slick.js`,
`slick.css`, `slick-theme.css`); the module never uses a CDN. `ept_slick_slider.install`
`hook_requirements($phase == 'install')` emits an **error** if the `media` module is on but no
`image` Media type exists (the slide image field targets it). There is **no settings form and no
configure route** — all configuration is per-paragraph; site-wide EPT defaults (colors, breakpoints)
live on `ept_core`'s own config form.

To use: add/enable a Paragraphs (`entity_reference_revisions`) field on a node/entity and allow the
`ept_slick_slider` bundle.

## Config shipped (config/install)
- `paragraphs.paragraphs_type.ept_slick_slider` — container bundle, label "EPT Slick Slider".
- `paragraphs.paragraphs_type.ept_slick_slider_item` — slide bundle, label "EPT Slick Slider Item".
- `field.storage.paragraph.field_ept_slick_slider` — `entity_reference_revisions`, target
  `paragraph`, **cardinality -1**, translatable. (Storages for the item fields — `_image`, `_link`,
  `_text` — ship here too; `field_ept_settings` / `field_ept_title` / `field_ept_text` storages come
  from ept_core.)
- `field.field.paragraph.ept_slick_slider.field_ept_slick_slider` — the slides field; handler
  `default:paragraph`, `target_bundles: { ept_slick_slider_item }`, label "Slick Slider".
- `field.field.paragraph.ept_slick_slider.field_ept_settings` — `ept_settings` (shared design/options
  tab), widget `ept_settings_slick_slider`.
- `field.field.paragraph.ept_slick_slider.field_ept_title` / `field_ept_text` — `text_long`, optional.
- Item fields on `ept_slick_slider_item`:
  - `field_ept_slick_slider_image` — `entity_reference` → media, `target_bundles: { image }`,
    **required**, label "Slide Image".
  - `field_ept_slick_slider_text` — `text_long`, optional, label "Slide Text".
  - `field_ept_slick_slider_link` — `link` (`link_type: 17` = both internal/external, no title),
    optional, label "Slide Link".
- `image.style.ept_slick_slider_card` — `image_scale_and_crop` 400x300 center.
- `core.entity_form_display.paragraph.ept_slick_slider.default` — `field_group` **Tabs**:
  **Content** tab (`field_ept_title`, `field_ept_text`, `field_ept_slick_slider` via the `paragraphs`
  widget, `edit_mode: open`, `add_mode: dropdown`, features collapse_edit_all + duplicate) and a
  closed **Settings** tab (`field_ept_settings` with the `ept_settings_slick_slider` widget).
- View displays render `field_ept_slick_slider` via `entity_reference_revisions_entity_view`,
  `field_ept_settings` via `ept_settings_default` (this is what emits the design CSS + drupalSettings).

**No config/schema/ directory** — the `ept_settings` schema is provided by `ept_core`; this module
adds none.

## The options widget — `EptSettingsSlickSliderWidget`
`src/Plugin/Field/FieldWidget/EptSettingsSlickSliderWidget.php`,
`@FieldWidget(id = "ept_settings_slick_slider", field_types = {"ept_settings"})`, extends
`Drupal\ept_core\Plugin\Field\FieldWidget\EptSettingsDefaultWidget`.

`formElement()` = `parent::formElement()` (the shared ept_core **Design** options — CSS box
margins/paddings/borders, background color/image, container width, edge-to-edge, title options)
**plus** a hidden `pass_options_to_javascript = TRUE` (this is what makes ept_core serialize the
settings into `drupalSettings.eptSlickSlider`) **plus** the Slick options below, all keyed under
`ept_settings`:

Top-level: `styles` (radios: `basic`|`without_styles`, default basic), `autoWidth`, `autoplay`
(checkbox with class `ept-autoplay-field`), `autoplaySpeed` (number, disabled unless autoplay checked),
`arrows` (default 1), `centerMode`, `centerPadding` (textfield, default `50px`), `dots`, `infinite`
(default 1), `initialSlide` (number), `lazyLoad` (radios `ondemand`|`progressive`), `mobileFirst`,
`slidesToShow` (default 1), `slidesToScroll` (default 1), `speed` (default 300), `variableWidth`.

`responsive` (details) → three sub-groups `mobile` / `tablet` / `desktop`, each with `breakpoint`
(textfield; defaults 576 / 992 / 1200), `slidesToShow`, `slidesToScroll`, `centerMode` (checkbox),
`centerPadding` (textfield).

`additional` (details): `accessibility` (default 1), `adaptiveHeight`, `draggable` (default 1),
`cssEase` (default `ease`), `fade`, `focusOnSelect`, `easing` (default `linear`), `edgeFriction`
(default `0.15`), `pauseOnFocus`/`pauseOnHover`/`pauseOnDotsHover` (default 1), `respondTo` (radios
window|slider|min), `rows`/`slidesPerRow` (default 1), `swipe` (default 1), `swipeToSlide`, `touchMove`
(default 1), `touchThreshold` (default 5), `useCSS`/`useTransform` (default 1), `vertical`,
`verticalSwiping`, `rtl`, `waitForAnimate` (default 1), `zIndex` (default 1000).

`massageFormValues()` only guarantees each delta has an `ept_settings` array; it does no filtering or
validation. There is no free-text field here that feeds the inline `{{ styles }}` CSS — the free-text
options (centerPadding, cssEase, easing, edgeFriction, touchThreshold, zIndex, breakpoints) flow only
into JS Slick options.

## Client init — `js/slick-slider.js`
`Drupal.behaviors.eptSlickSlider.attach()` iterates `drupalSettings.eptSlickSlider`; for each it finds
`'.' + paragraphClass + ' .slides'`, guards against double-init with the `slick-slider-added` class,
translates `options` (booleans from 1/0, ints via `parseInt`, strings via `Drupal.checkPlain()`),
assembles a `responsive[]` array of `{breakpoint, settings}` from the mobile/tablet/desktop groups,
then calls `$paragraphSlider.slick(options)`. Finally it sets `overflow:hidden` on the closest
`.layout__region` (Slick + flexbox fix). (Minor upstream bugs exist — e.g. the `focusOnSelect` branch
tests `additional.additional` — but none affect security.)

## Rendering — templates & libraries
Registered by `EptSlickSliderHooks::themeRegistryAlter()` (`#[Hook('theme_registry_alter')]`, wrapped
by the legacy `ept_slick_slider_theme_registry_alter()` in the `.module`; service defined in
`ept_slick_slider.services.yml`, autowired):
- `templates/paragraph--ept-slick-slider--default.html.twig` — container. Builds wrapper classes
  (`ept-slick-slider`, `<styles>-styles`, `paragraph-id-N`, …), conditionally
  `attach_library('ept_slick_slider/basic')` when style == basic, always
  `attach_library('ept_slick_slider/slick_slider')`, prints an optional `field_ept_title` heading
  (wrapper tag from shared `title_options.title_wrapper`; optional `striptags` allowlist), then
  `{{ content|without('field_ept_settings','field_ept_title') }}`, and ends with `{{ styles|raw }}`
  — the scoped inline `<style>.paragraph-id-N{…}</style>` assembled by **ept_core**'s `GenerateCSS`
  from the design tab (this is ept_core output, not this module's).
- `templates/field--paragraph--field-ept-slick-slider--ept-slick-slider.html.twig` — wraps the slide
  items in `<div class="slides">` / `<div class="slide">…</div>`; the `.slides` element is what
  `js/slick-slider.js` calls `.slick()` on.
- `templates/paragraph--ept-slick-slider-item--default.html.twig` — one slide; wraps content in an
  `<a href="{{ content.field_ept_slick_slider_link.0['#url'] }}">` when a Slide Link is set.
- Library `ept_slick_slider/slick_slider`: JS `/libraries/slick/slick/slick.js` + `js/slick-slider.js`;
  CSS `/libraries/slick/slick/slick.css` + `slick-theme.css`; deps core/drupal, jquery, once,
  drupalSettings. Library `ept_slick_slider/basic`: `css/basic/slick-basic.css`.

## Notes for agents
- No routes/permissions/services (beyond the hook wrapper)/schema/drush/settings-form. All behavior is
  per-paragraph config + client JS.
- Slide images are Media (`image` bundle); change the crop by editing the view display to use
  `ept_slick_slider_card` or another image style via Fields UI.
- To restyle, pick "Without styles" and theme `.slides`/`.slide` yourself, or override the templates
  in your theme.
