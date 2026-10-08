# Block type, slides, displays and the FlexSlider runtime

Everything here is imported at install from `config/install/` — the module has no settings form. The
component is a `block_content` bundle whose body is a list of paragraph "slides".

## Entities and fields

**Block content type `ebt_slideshow`** (`block_content.type.ebt_slideshow.yml`, label "EBT Slideshow")
carries two fields:

| Field | Type | Notes |
|---|---|---|
| `field_ebt_slideshow` | `entity_reference_revisions` → paragraph | `cardinality: -1` (unlimited); `target_bundles: {ebt_slideshow}`. The slides. |
| `field_ebt_settings` | `ebt_settings` | Storage/field type provided by `ebt_core`. Holds the FlexSlider + design options. Widget = `ebt_settings_slideshow` (see [../fields/widget.md](../fields/widget.md)). |

**Paragraph type `ebt_slideshow`** (label "EBT Slide") is a single slide:

| Field | Type | Notes |
|---|---|---|
| `field_ebt_slideshow_slide` | `entity_reference` → media bundle `image` | **Required** (`update_9102`). Widget `media_library_widget`. |
| `field_ebt_slideshow_title` | `text_long` | `text_textarea` widget (5 rows). |
| `field_ebt_slideshow_text` | `text_long` | `text_textarea` widget (5 rows). |
| `field_ebt_slideshow_link` | `link` | Optional; wraps the slide image in an `<a>` when present. |

## Form and view displays

- **Block form display** (`core.entity_form_display.block_content.ebt_slideshow.default.yml`) uses
  `field_group` to split the edit form into two tabs: **Content** (`field_ebt_slideshow`, an
  `entity_reference_paragraphs` widget, `add_mode: dropdown`, `edit_mode: open`) and **Settings**
  (`field_ebt_settings` via widget `ebt_settings_slideshow`). Requires `field_group` and `paragraphs`.
- **Block view display** shows `field_ebt_slideshow` with `entity_reference_revisions_entity_view`
  (view mode `default`) and hides `field_ebt_settings` (the settings are consumed by JS, not printed).
- **Paragraph view display** renders the slide image as `media_thumbnail` (lazy), title/text as
  `text_default`, and the link as `link`.

## Templates and theme hook suggestions

Four Twig templates in `templates/` (registered by their filename as theme-hook suggestions):

- `block--block-content--ebt-slideshow.html.twig` and `block--inline-block--ebt-slideshow.html.twig` —
  the outer block wrapper. Add classes `ebt-block ebt-block-<plugin_id> …`, print an optional `<h2>`
  label, `attach_library('ebt_slideshow/flexslider')`, and emit `{{ styles|raw }}` (inline CSS built
  by `ebt_core` from the design options).
- `field--block-content--field-ebt-slideshow--ebt-slideshow.html.twig` — the slideshow itself. Wraps
  the field in `.ebt-slideshow-wrapper.flexslider` and renders each referenced slide as
  `<div class="slide">` inside `.slides` (the FlexSlider structure the JS binds to).
- `paragraph--ebt-slideshow--default.html.twig` — one slide. If `field_ebt_slideshow_link` is set it
  wraps the slide image in `<a href="…">`; otherwise prints the paragraph content. Also
  `attach_library('ebt_slideshow/flexslider')`.

## FlexSlider JS runtime

Library `ebt_slideshow/flexslider` = `js/flexslider/flexslider.js` + `css/flexslider/flexslider.css`,
plus the composer-installed core at `/libraries/flexslider/jquery.flexslider-min.js` and
`/libraries/flexslider/flexslider.css`. Deps: `core/drupal`, `core/jquery`, `core/once`,
`core/drupalSettings`.

`Drupal.behaviors.ebtSlideshow` (`flexslider.js`) iterates `drupalSettings.ebtSlideshow`. Each entry
provides a `blockClass` (the per-block wrapper class) and an `options` object. The behavior:

1. Finds `.<blockClass>`; skips if absent or already carrying `flexslider-added`.
2. Builds a FlexSlider `options` map from `options.*` (see [../fields/widget.md](../fields/widget.md)
   for every key). Text options (`animation`, `direction`, `prevText`, `nextText`, `pauseText`,
   `playText`) pass through `Drupal.checkPlain()`; numeric options through `parseInt()`; booleans map
   `1 → true`. `options.selector` is forced to `.slides > .slide`.
3. Calls `$block.find('.ebt-slideshow-wrapper').flexslider(options)` and adds the `flexslider-added`
   guard class.

`drupalSettings.ebtSlideshow` is populated by `ebt_core` (which reads `field_ebt_settings` and only
emits JS options when the widget's hidden `pass_options_to_javascript` flag is TRUE — this widget sets
it TRUE). A carousel is just `animation: slide` plus the carousel `minItems`/`maxItems`/`itemWidth`
options.

## Install / uninstall

- `hook_requirements` (install phase) errors unless an `image` **media type** exists — create one at
  `/admin/structure/media` first.
- `ebt_slideshow_update_8001` installs `media` and `media_library`; `_9101` relabels the paragraph
  type to "EBT Slide"; `_9102` makes the slide image required.
- On uninstall the block/paragraph types and their content are **kept** (a status message points to
  the custom block library) — uninstalling does not remove existing slideshow blocks.

## Place a slideshow

Enable the module (after creating an `image` media type), then add a block of type "EBT Slideshow" at
`admin/content/block/add/ebt_slideshow` (or via Layout Builder / block placement). Add one or more
slides on the **Content** tab, tune FlexSlider on the **Settings** tab.
