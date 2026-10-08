<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Paragraphs behavior plugin

```bash
composer require drupal/bs_slider drupal/paragraphs
drush en bs_slider_paragraphs -y
```

## Plugin `bs_slider` (BsSliderParagraphsBehavior)

`src/Plugin/paragraphs/Behavior/BsSliderParagraphsBehavior.php`,
`@ParagraphsBehavior(id = "bs_slider", label = "BS Slider", weight = 0)`, extends
`ParagraphsBehaviorBase`, implements `BsSliderPluginOptionInterface` +
`ContainerFactoryPluginInterface`. DI: `entity_field.manager`,
`bs_slider_configuration.manager`, `entity_type.manager`, `entity_display.repository`,
`module_handler`, `current_user`.

`defaultConfiguration()` = `['field_name' => '', 'bs_slider' => [], 'options' => []]`.

## Type-level configuration form (`buildConfigurationForm`)

Shown on the Paragraph type's **Behaviors** tab. Returns `[]` for a new (unsaved) type.

- `field_name` — select of the type's fields with **cardinality > 1**
  (`getFieldsByCardinalityGreaterOne()`); the mapped field supplies slider items. If the type has
  no such field, an error message with a link to *Manage fields* is shown instead.
- `bs_slider` — a fieldset with a checkbox per optionset (`manager->getAllOptionSet()`); enabling a
  checkbox reveals (via AJAX, `updatePluginOptionsAjax`) that plugin's option form
  (`$plugin->buildPluginOptionsForm($form, $form_state, $this)` — typically view-mode selects),
  wrapped in a `panel` div.

`validateConfigurationForm()` errors if no `field_name` is chosen. `submitConfigurationForm()`
stores `field_name` and, for each checked optionset, its `options` into
`configuration['bs_slider']`.

`getPluginOptions('target_field_view_modes')` → returns the mapped field's target-type view modes
(`getEntityRefFieldViewModes()` reads the field's `target_type` setting);
`getPluginOptionValue($name)` reads from `configuration['options']`.

## Per-paragraph behavior form (`buildBehaviorForm`)

On each paragraph instance: a `bs_slider` select limited to the enabled optionsets (intersected
with `configuration['bs_slider']`), empty option "- None -", stored via `submitBehaviorForm()` as a
behavior setting. `settingsSummary()` shows the chosen slider on the paragraph summary line.

## Render path (`view`)

`view(&$build, Paragraph $paragraph, $display, $view_mode)`:

1. Reads the paragraph's `bs_slider` behavior setting; returns if none.
2. If the mapped `field_name` is present in `$build` and the chosen optionset is configured, loads
   the optionset (`entityLoad`) and plugin (`getPlugin`).
3. Calls `$plugin->view($build[$field_name], $bs_slider,
   $configuration['bs_slider'][$optionset])` — replacing the field's render array with the slider.

## Notes

- Only fields with cardinality > 1 are mappable (a slider needs multiple items).
- The optionset's plugin (and its library) must come from an enabled library submodule.
- All configuration is authored by users with Paragraphs type-admin / paragraph-edit access; the
  behavior itself adds no new permission.
