<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tiny Slider plugin

```bash
drush en bs_slider_tiny_slider -y
# Self-host tns at web/libraries/tiny-slider/dist/ (min/tiny-slider.js + tiny-slider.css)
```

## `tiny_slider` (BsSliderTinySlider extends BsSliderBase)

- `defaultConfiguration()` = `['configuration' => '']`.
- `buildConfigurationForm()` adds one field: `$form['options']['configuration']`, a 15-row
  `textarea` for the tns configuration **in YAML**. The description says not to use the tns
  `container` option (the module sets it). Schema `bs_slider.options.tiny_slider` (`configuration`
  string).
- `buildPluginOptionsForm()` adds a required `view_mode` select for the consumer (only when
  `target_field_view_modes` is available).
- `preprocess()`:
  - `$variables['items'] = $variables['element']['#items']`.
  - `attributes['id'] = element #id`, `attributes['data-bs-slider'] = 'tiny-slider'`.
  - `attributes['data-bs-slider-options'] = json_encode(Yaml::parse($options['configuration']))`.
    (Values are written through Drupal's `Attribute` object → escaped. YAML parsing is
    scalar/array only. Config is authored via the `administer bs_slider` optionset form.)
- `view()` calls `parent::view()` then attaches `bs_slider_tiny_slider/tiny-slider`.

## JS (`js/tiny-slider.js`)

`Drupal.behaviors.bsSliderTinySlider` selects `[data-bs-slider="tiny-slider"]`, guards re-init with
`dataset.bsSliderInit`, `JSON.parse`s `dataset.bsSliderOptions`, sets `options.container = slider`,
then `slider.bsSlider = tns(options)`.

## Library (`bs_slider_tiny_slider.libraries.yml`)

`tiny-slider` → CSS `/libraries/tiny-slider/dist/tiny-slider.css`, JS
`/libraries/tiny-slider/dist/min/tiny-slider.js` + `js/tiny-slider.js`; depends on `core/drupal`.
The tns library is **not bundled** — self-host it.

## Config example (optionset)

```yaml
# bs_slider.configuration.my_tns.yml
id: my_tns
label: 'My Tiny Slider'
status: true
plugin_id: tiny_slider
options:
  configuration: |
    items: 1
    autoplay: true
    controls: true
    nav: false
    gutter: 10
    responsive:
      768:
        items: 3
```

## Notes

- No per-option UI and no default optionset options beyond the empty YAML — an empty
  `configuration` yields `Yaml::parse('')` → `null` → `data-bs-slider-options="null"`; supply valid
  YAML for a working slider.
