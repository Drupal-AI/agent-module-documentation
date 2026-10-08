# Hooks

Documented in `maxlength.api.php`.

## `hook_maxlength_widget_settings()`

Register additional field widget plugin ids that should offer MaxLength settings,
and which of the three toggles each supports. Merged into the built-in list by
`WidgetSettings::getAllowedSettingsForAll()` (invoked with `module_handler->invokeAll`).

```php
function mymodule_maxlength_widget_settings() {
  return [
    'my_custom_text_widget' => [
      'maxlength_setting' => TRUE,          // show the main length + countdown fields
      'summary_maxlength_setting' => TRUE,  // also show summary length + countdown
      'truncate_setting' => TRUE,           // show the "Hard limit" checkbox
    ],
  ];
}
```

Return an array keyed by widget plugin id. Each value's three booleans decide which
sub-settings render in the widget's MaxLength Settings form. That is the only hook
the module provides.
