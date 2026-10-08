# Hooks — alter Slick output

Defined in `slick.api.php`. Use them to change JS options, optionsets, or the final build.
Implement in `mymodule.module`.

- `hook_slick_overridable_options_info_alter(&$options)` — declare which Slick JS options may
  be overridden per-display (adds/removes options exposed on formatter/optionset forms).
- `hook_slick_optionset_alter(Slick &$slick, array $settings)` — mutate the loaded optionset
  entity before it is turned into JS options (e.g. force `autoplay` off in a context).
- `hook_slick_options_alter(array &$options, array $settings, Slick $slick)` — alter the final
  JS options array sent to drupalSettings (last chance before rendering).
- `hook_slick_settings_alter(array &$build, $items)` — alter the whole build (`$build`) and its
  settings just before theming; use for adding attributes, changing skin, etc.

```php
/**
 * Implements hook_slick_options_alter().
 */
function mymodule_slick_options_alter(array &$options, array $settings, $slick) {
  if (($settings['optionset'] ?? '') === 'hero') {
    $options['autoplaySpeed'] = 6000;
    $options['pauseOnHover'] = TRUE;
  }
}
```

The module also implements several core hooks itself in `slick.module`:
`hook_theme()`, `hook_library_info_build()`, `hook_library_info_alter()`,
`hook_config_schema_info_alter()`, and `hook_page_attachments()` (sitewide auto-attach).
