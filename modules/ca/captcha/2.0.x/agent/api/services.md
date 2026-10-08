# Services & helper functions

### Service `captcha.helper` — `Drupal\captcha\Service\CaptchaService`
- `getAvailableChallengeTypes(bool $add_special_options = TRUE): array` — map of
  `module/type` → human label, gathered from every `hook_captcha('list')`. Include the
  `'default'` option when `$add_special_options` is TRUE. Use to build a select list.
- `insertCaptchaElement(array &$form, ?array $placement, ?array $captcha_element)` — inject a
  CAPTCHA element into a form at a given placement (path/key/weight).

```php
$types = \Drupal::service('captcha.helper')->getAvailableChallengeTypes();
```

### Procedural helpers (`captcha.inc`, auto-loaded)
- `captcha_set_form_id_setting($form_id, $captcha_type)` — create/update a CAPTCHA point.
- `captcha_get_form_id_setting($form_id, $symbolic = FALSE)` — read a form's CAPTCHA config.

### Adding a challenge without a point
The simplest way to protect your own form is to add the render element directly
(see [../theming/element.md](../theming/element.md)):
```php
$form['captcha'] = [
  '#type' => 'captcha',
  '#captcha_type' => 'image_captcha/Image', // or 'default'
];
```

### Other
- `captcha.config_subscriber` (`CaptchaCachedSettingsSubscriber`) — internal; rebuilds cached
  element info when settings change.
- `hook_cron` (`captcha_cron`) purges stale rows from the `captcha_sessions` table.
