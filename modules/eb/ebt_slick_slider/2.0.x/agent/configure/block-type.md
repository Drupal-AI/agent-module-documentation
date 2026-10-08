# Block type, slides, displays and the Slick runtime

Everything here is imported at install from `config/install/` — the module has no settings form. The
component is a `block_content` bundle whose body is a list of paragraph "slides".

## Entities and fields

**Block content type `ebt_slick_slider`** (`block_content.type.ebt_slick_slider.yml`, label "EBT Slick
Slider") carries:

| Field | Type | Notes |
|---|---|---|
| `field_ebt_slick_slider` | `entity_reference_revisions` → paragraph | `cardinality: -1` (unlimited); `target_bundles: {ebt_slick_slider}`. The slides. |
| `field_ebt_settings` | `ebt_settings` | Storage/field type provided by `ebt_core`. Holds the Slick + design options. Widget = `ebt_settings_slick_slider` (see [../fields/widget.md](../fields/widget.md)). |
| `body` | `text_with_summary` | Optional description printed above the slider (`.slider-description`). |

**Paragraph type `ebt_slick_slider`** (label "EBT Slick Slide") is a single slide:

| Field | Type | Notes |
|---|---|---|
| `field_ebt_slick_slider_image` | `entity_reference` → media bundle `image` | **Required** (`update_9101`). Widget `media_library_widget`. |
| `field_ebt_slick_slider_text` | `text_long` | `text_textarea` widget (5 rows). |
| `field_ebt_slick_slider_link` | `link` | Optional; when set, wraps the whole slide in an `<a href>`. |

## Form and view displays

- **Block form display** (`core.entity_form_display.block_content.ebt_slick_slider.default.yml`) uses
  `field_group` to split the edit form into two tabs: **Content** (`body`, and `field_ebt_slick_slider`
  as an `entity_reference_paragraphs` widget, `add_mode: dropdown`, `edit_mode: open`) and **Settings**
  (`field_ebt_settings` via widget `ebt_settings_slick_slider`, tab starts closed). Requires
  `field_group` and `paragraphs`.
- **Block view display** shows `field_ebt_slick_slider` with `entity_reference_revisions_entity_view`
  (view mode `default`) and hides nothing structural, but `field_ebt_settings` is rendered with the
  `ebt_settings_default` formatter (the settings are consumed by JS/CSS, not printed as content).
- **Paragraph view display** renders the slide image as `media_thumbnail` with image style
  `slick_slider_card` (lazy loading), the text as `text_default`, and the link as `link`.

## Image style

`image.style.slick_slider_card.yml` defines `slick_slider_card`: a single `image_scale_and_crop` effect
at **400×300**, anchor `center-center`. It is the default formatter setting for the slide image, so
changing slide-image dimensions is a matter of editing this style or the paragraph view display.

## Templates and theme hook suggestions

Four Twig templates in `templates/` (registered by filename as theme-hook suggestions):

- `block--block-content--ebt-slick-slider.html.twig` and `block--inline-block--ebt-slick-slider.html.twig` —
  the outer block wrapper. Add classes `ebt-block ebt-slick-slider ebt-block-<plugin_id> …` plus a
  `<styles>-styles` class taken from the selected slider style; print an optional `<h2>` label and the
  `body`; `attach_library('ebt_slick_slider/slick_slider')` (and `…/basic` when the "Basic" style is
  chosen); and emit `{{ styles|raw }}` (inline CSS built by `ebt_core` from the design options, values
  `Html::escape`-d in `ebt_core`'s `GenerateCSS`).
- `field--block-content--field-ebt-slick-slider--ebt-slick-slider.html.twig` — the slider itself.
  Wraps the referenced slides in `.slides` and renders each as `<div class="slide">` (the structure
  the JS binds to).
- `paragraph--ebt-slick-slider--default.html.twig` — one slide. If `field_ebt_slick_slider_link` is
  set it wraps the slide content in `<a href="{{ …link.0['#url'] }}">` (a `link`-field URL, autoescaped
  by Twig); otherwise prints the content.

## Slick JS runtime

Library `ebt_slick_slider/slick_slider` = `js/slick-slider.js` plus the composer-installed Slick core
at `/libraries/slick/slick/slick.js`, `slick.css`, `slick-theme.css`. Deps: `core/drupal`,
`core/jquery`, `core/once`, `core/drupalSettings`.

`Drupal.behaviors.ebtSlickSlider` (`slick-slider.js`) iterates `drupalSettings.ebtSlickSlider`. Each
entry provides a `blockClass` (the per-block wrapper class) and an `options` object. The behavior:

1. Finds `.<blockClass>`; skips if absent, and skips `.<blockClass> .slides` if it already carries
   `slick-slider-added`.
2. Builds a Slick `options` map from `options.*` (see [../fields/widget.md](../fields/widget.md) for
   every key). String options (`centerPadding`, `lazyLoad`, `easing`, `edgeFriction`, `respondTo`,
   `zIndex`, …) pass through `Drupal.checkPlain()`; numeric options through `parseInt()`; checkboxes
   map `1 → true`, `0 → false`. Responsive mobile/tablet/desktop breakpoints are assembled into
   Slick's `responsive: [{breakpoint, settings}]` array.
3. Calls `$('.<blockClass> .slides').slick(options)`, adds `slick-slider-added`, and forces the
   enclosing `.layout__region` to `overflow:hidden` (a known Slick + flexbox workaround).

`drupalSettings.ebtSlickSlider` is populated by `ebt_core` (which camel-cases the bundle name to build
the drupalSettings key and only emits JS options when the widget's hidden `pass_options_to_javascript`
flag is TRUE — this widget sets it TRUE).

Behaviour bugs worth knowing (present in 2.0.0, harmless): the `focusOnSelect` branch tests
`drupalBlockSettings.additional.additional` (a typo) so it never forwards `focusOnSelect`; and the
responsive `centerPadding` is read into a local `…EdgePadding` variable but forwarded only if a
differently-named `…CenterPadding` variable exists, so per-breakpoint `centerPadding` is effectively
never applied.

## Install / uninstall

- `hook_requirements` (install phase) errors unless an `image` **media type** exists — create one at
  `/admin/structure/media` first. (The check is skipped if `media` is not enabled, but the config
  install itself depends on `media.type.image`, so `media` is effectively required.)
- `ebt_slick_slider_update_9101` makes `field_ebt_slick_slider_image` required.
- On uninstall the block/paragraph types and their content are **kept** (a status message points to
  the custom block library) — uninstalling does not remove existing slider blocks.

## Place a slider

Enable the module (after creating an `image` media type), then add a block of type "EBT Slick Slider"
at `admin/content/block/add/ebt_slick_slider` (or via Layout Builder / block placement). Add one or
more slides on the **Content** tab, tune Slick on the **Settings** tab.
