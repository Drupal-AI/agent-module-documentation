# Hook: `hook_message_banner_colors_alter`

Declared in `message_banner.api.php`. Lets a module add to (or replace) the banner color
options offered in the settings form's *Banner color* select. Invoked in
`MessageBannerSettingsForm::getBannerColors()` via `moduleHandler->alter('message_banner_colors', $colors)`.

- **Signature:** `hook_message_banner_colors_alter(array &$colors)`.
- **`$colors`:** keyed array `machine_class => t('Human label')`. The key is emitted as a CSS class
  on the banner (via `template_preprocess_message_banner`, which appends the saved `banner_color`),
  so define matching CSS in your theme.
- Defaults you can extend/override: `default--red`, `default--amber`, `default--green`,
  `default--black`, `default--gray`, `default--white`.

```php
function mymodule_message_banner_colors_alter(array &$colors) {
  $colors['brand-blue'] = t('Brand blue');   // add
  unset($colors['default--white']);          // remove a default
}
```

No other hooks are provided by this module.
