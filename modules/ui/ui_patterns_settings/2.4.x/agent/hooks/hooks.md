# Hooks (ui_patterns_settings.api.php)

Two alter hooks let code override a pattern's resolved settings/variant just before render.
`$context` carries `#pattern_id`, `#variant`, and `#context`.

## `hook_ui_pattern_settings_settings_alter(array &$settings, array $context)`

Override the configured setting values for specific patterns.

```php
function mymodule_ui_pattern_settings_settings_alter(array &$settings, array $context) {
  if ($context['#pattern_id'] === 'button') {
    $settings['padding_bottom'] = 'large';
  }
}
```

## `hook_ui_pattern_settings_variant_alter(&$variant, array $context)`

Override which variant a pattern renders.

```php
function mymodule_ui_pattern_settings_variant_alter(&$variant, array $context) {
  if ($context['#pattern_id'] === 'section') {
    $variant = 'column_1';
  }
}
```

Both are documented in `ui_patterns_settings.api.php` and fire from the
`PatternSettings` render element pipeline.
