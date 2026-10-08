# Hooks (entity_browser.api.php)

One `*_info_alter` hook per plugin type, plus form and view alters. All alter the array
of plugin definitions keyed by machine name.

- `hook_entity_browser_display_info_alter(&$displays)`
- `hook_entity_browser_widget_info_alter(&$widgets)`
- `hook_entity_browser_selection_display_info_alter(&$selection_displays)`
- `hook_entity_browser_widget_selector_info_alter(&$widget_selectors)`
- `hook_entity_browser_field_widget_display_info_alter(&$field_displays)`
- `hook_entity_browser_widget_validation_info_alter(&$validation_plugins)`

Form alters (browsers render a form with base id `entity_browser_form`):

- `hook_form_entity_browser_form_alter(&$form, $form_state, $form_id)` — every browser.
- `hook_form_entity_browser_ENTITY_BROWSER_ID_form_alter(...)` — one specific browser.

View widget:

- `hook_entity_browser_view_executable_alter(ViewExecutable &$view, array &$configuration, array $context)`
  — adjust the View (e.g. inject contextual arguments) before the `view` widget renders it.

```php
function mymodule_entity_browser_widget_info_alter(array &$widgets) {
  $widgets['view']['label'] = t('Browse library');
}
```
