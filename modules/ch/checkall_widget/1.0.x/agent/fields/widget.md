<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkall Widget — field widget plugin & behavior

## Install / enable
`composer require drupal/checkall_widget` then `drush en checkall_widget`. No dependencies
beyond Drupal core.

## Enable per field
Admin UI: the field's **Manage form display** tab → set the widget to
**"Checkall Widget : Check all boxes/radio buttons"**. Available whenever the field type is
one of `boolean`, `entity_reference`, `list_integer`, `list_float`, `list_string` and the
field allows multiple values (the plugin declares `multiple_values = TRUE`). No widget
settings form is added, so there is nothing further to configure.

## Plugin
`Drupal\checkall_widget\Plugin\Field\FieldWidget\CheckallOptionsWidget`
(annotation id `checkall_widget_options_buttons`), extends core
`Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsButtonsWidget`.

`formElement()` calls `parent::formElement()` (the standard checkbox/radio render array),
then appends a `container` (`#attributes` class `checkall-widget`) holding two
`html_tag` `<button>` elements:
- **Check all** — `data-check-all` attribute TRUE, `#value` `t('Check all')`.
- **Uncheck all** — `data-check-all` FALSE, `#value` `t('Uncheck all')`.

Both use classes `checkall-widget-btn button--small`. The method attaches
`$element['#attached']['library'][] = 'checkall_widget/checkall_widget'`. All labels go
through `t()`; there is no user-supplied or config-supplied string rendered into markup.
No `settingsForm()`, `settingsSummary()`, or `massageFormValues()` override — value
handling is 100% inherited from `OptionsButtonsWidget`, so stored data is identical to the
core widget.

## Behavior (JS)
Library `checkall_widget/checkall_widget` = `js/checkall_widget.js` + core deps
`core/jquery`, `core/drupal`. Behavior `Drupal.behaviors.checkall_widget` binds `click` on
`.checkall-widget-btn`, calls `e.preventDefault()`, then within the enclosing
`.field--widget-checkall-widget-options-buttons` wrapper sets every `input`'s `checked`
prop to `typeof $(this).data('checkAll') !== 'undefined'` — i.e. the Check-all button
(which has the data attribute) checks all inputs, the Uncheck-all button clears them.

## Notes / caveats
- The client toggle sets `checked` on **all** `input` elements inside the widget wrapper,
  including radios — designed for checkboxes (multi-value); on single-value/radio configs
  behavior is not meaningful.
- Purely a display-layer convenience; disabling the module or switching the widget back to
  core leaves stored field values intact.
