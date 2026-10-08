<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Core field formatters

`bs_slider` ships three field formatters in `src/Plugin/Field/FieldFormatter/`. All select an
**optionset** (`bs_slider` setting) and delegate rendering to that optionset's `BsSlider` plugin.
Set them under *Manage display* on a field (or via `core.entity_view_display.*` config).

## Shared plumbing

- **`BsSliderFormatterTrait`** — `getSettingsFormElements()` builds the `bs_slider` select
  (options from `manager->getAllOptionSet()`, `#required`, AJAX-refreshed) plus, when the active
  plugin returns any, a `Plugin options` fieldset from `$plugin->buildPluginOptionsForm(...)`.
  `settingsSummary()` appends `BS Slider: {label}`. The trait holds the `bs_slider_configuration.manager`
  as `$this->manager`.
- **`BsSliderEntityReferenceFormatterBase`** (abstract, extends core
  `EntityReferenceEntityFormatter`, implements `BsSliderPluginOptionInterface`). `defaultSettings()`
  = `['bs_slider' => NULL, 'options' => []] + parent`. `getPluginOptions('target_field_view_modes')`
  returns the referenced type's view modes. `viewElements()` builds the referenced-entity render
  array via `parent::viewElements()`, loads the optionset + plugin, then calls
  `$plugin->view($build, $bs_slider, $this->getSetting('options'))`.

## `bs_slider_media` — "BS Slider Media"

`BsSliderMediaFormatter` extends `BsSliderEntityReferenceFormatterBase`. `field_types =
{entity_reference}` (works for media reference fields, and any entity_reference). Adds
`options.view_mode` (the view mode each referenced item is rendered in). Quickedit disabled.

## `bs_slider_media_gallery` — "BS Slider Media Gallery"

`BsSliderMediaGalleryFormatter` extends the same base. `field_types = {entity_reference}`. Adds two
settings — `options.thumbnail_view_mode` and `options.item_view_mode` — so the gallery renders a
thumbnail strip and a separate full view. Its `settingsSummary()` lists both. Pair it with a
gallery-capable plugin (e.g. `bootstrap_gallery_grid`, `swiper_thumbs_gallery`).

## `bs_slider_text` — "BS Slider Text"

`BsSliderTextFormatter` extends core `FormatterBase` directly (not the entity-reference base).
`field_types = {text, text_long, text_with_summary}`. `defaultSettings()` = `['bs_slider' =>
'default']`. `viewElements()` loads the optionset + plugin, calls `$plugin->view($build, …,
['view_mode' => $this->viewMode])`, then fills `$build['#items']` with one
`#type => processed_text` element per field item (`#text`, `#format`, `#langcode`). Because it uses
`processed_text`, the field's own text format (and its filters) is applied — output is rendered
through the standard filter pipeline, and cache metadata bubbles via core's `ProcessedText`.

## Config example (view display)

```yaml
# core.entity_view_display.node.article.default
content:
  field_gallery:                 # an entity_reference (media) field
    type: bs_slider_media
    label: hidden
    settings:
      bs_slider: homepage_carousel     # an existing bs_slider.configuration.* id
      options:
        view_mode: default
```

## Related formatter in a submodule

`entity_reference_revisions` fields use the ERR submodule's formatter instead →
[../../modules/bs_slider_entity_reference_revision/1.0.x/agent/fields/formatter.md](../../modules/bs_slider_entity_reference_revision/1.0.x/agent/fields/formatter.md).

## Notes

- The `bs_slider` select is `#required`; if no optionsets exist yet the formatter can't render —
  create one first at *Config → Media → BS Slider*.
- Item view modes come from the referenced entity type, so the target-type must have the chosen
  view mode enabled.
