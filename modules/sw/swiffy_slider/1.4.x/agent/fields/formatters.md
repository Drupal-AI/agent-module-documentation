<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three Swiffy Slider field formatters

## Install & enable

```bash
composer require drupal/swiffy_slider
drush en swiffy_slider -y
```

The required JS/CSS library is bundled under `assets/vendor/dynamicweb/swiffy-slider`, so nothing
extra is needed. To pin/override the version, install `dynamicweb/swiffy-slider` into `/libraries`
(README shows the composer package snippet); `hook_library_info_alter()` in `swiffy_slider.module`
then rewrites the library paths to `/libraries/swiffy-slider` when
`library.libraries_directory_file_finder` locates it.

No dependencies are declared in `swiffy_slider.info.yml`, but each formatter extends a core
formatter, so the relevant core module must be enabled: `image` for `swiffy_slider_image`, `text`
for `swiffy_slider_text_default` (`entity_reference`/`entity_reference_revisions` are core field
types).

## The formatters

All three live in `src/Plugin/Field/FieldFormatter/` and pull in
`SwiffySliderFieldFormatterTrait`:

| Plugin id | Class | Extends | Field types |
|---|---|---|---|
| `swiffy_slider_entity_reference` | `SwiffySliderEntityReferenceFormatter` | `EntityReferenceEntityFormatter` | `entity_reference`, `entity_reference_revisions` |
| `swiffy_slider_image` | `SwiffySliderImageFormatter` | `ImageFormatter` | `image` |
| `swiffy_slider_text_default` | `SwiffySliderTextDefaultFormatter` (PHP-attribute `#[FieldFormatter]`) | `TextDefaultFormatter` | `text`, `text_long`, `text_with_summary` |

Because they extend the core formatters, every inherited setting still applies (view mode for the
entity-reference one, image style / link for the image one, etc.) — the trait only *adds* slider
behaviour on top. All three are labelled **"Swiffy Slider"** in *Manage display*.

## Enable it on a field

UI: *Structure → (bundle) → Manage display* → set a multi-value field's format to **Swiffy
Slider** → click the gear → paste a **permalink** copied from `https://swiffyslider.com/configuration/`.

The formatter only produces a slider container; the sliding is meaningful on a **multi-value**
field. On a single-value field the template renders the item without the slider wrapper (see
Templates).

## The one added setting (`SwiffySliderFieldFormatterTrait`)

- `defaultSettings()` adds `swiffy_slider_permalink = NULL` and `unset()`s the inherited `link`
  setting.
- `settingsForm()` appends `swiffy_slider_permalink` built by
  `Configuration::configurationUrlElement()` (a `#type => url`, `#maxlength => 1000` field) and
  attaches an element-validate callback `emptyConfigurationUrlToNull()` that converts a
  whitespace-only value to `NULL`.
- `settingsSummary()` shows a link labelled *Customized* (to the saved URL) or *Default* (to the
  configurator base URL) via `Markup::create(...)`.
- `view()` calls `parent::view()` (so **core entity/field access and the normal render pipeline
  are honoured**), then — only when the item list is non-empty — attaches the
  `swiffy_slider/swiffy_slider-lib` library, sets `#swiffy_slider_attributes` to
  `Configuration::toAttributes($url)`, and calls `RenderHelper::attachCacheTags()`.
- `getConfiguredUrl()` returns the saved `swiffy_slider_permalink` or `NULL` (empty ⇒ `NULL`, so
  `toAttributes()` falls back to the global default, then the configurator base URL).

Schema: `config/schema/swiffy_slider.schema.yml` defines
`field.formatter.settings.swiffy_slider_entity_reference` (mapping: `view_mode` string +
`swiffy_slider_permalink` nullable `uri`) and `field.formatter.settings.swiffy_slider_image`
(extends `field.formatter.settings.image` + `swiffy_slider_permalink`). The text formatter reuses
core text schema plus the added key at runtime.

## Templates & preprocess

`swiffy_slider.module` registers theme hook `field__swiffy_slider_entity_reference`
(base hook `field`). `hook_theme_suggestions_field_alter()` adds that suggestion for any of the
three formatters, and `hook_preprocess_field()` copies `#swiffy_slider_attributes` into the
`swiffy_slider_attributes` Twig variable.

`templates/field--swiffy-slider-entity-reference.html.twig`: when `multiple`, wraps items in
`<div{{ swiffy_slider_attributes }}> <ul class="slider-container"> … </ul>` with two
`button.slider-nav` (previous / next) and a `.slider-indicators` block of one button per item;
otherwise it renders each item plainly (no slider chrome).

## Config-export example (image formatter)

```yaml
# core.entity_view_display.node.article.default
content:
  field_gallery:
    type: swiffy_slider_image
    label: hidden
    settings:
      image_style: large
      image_link: ''
      swiffy_slider_permalink: 'https://swiffyslider.com/?slider-nav-round=slider-nav-round&slider-indicators=slider-indicators'
```

The `swiffy_slider_permalink` is just the configurator permalink; how it becomes markup is covered
in [../config/settings-and-views.md](../config/settings-and-views.md).
