# CAPTCHA render element & theming

### Render element `#type => captcha`
Defined by `Drupal\captcha\Element\Captcha` (`src/Element/Captcha.php`). Add it to any form to
attach a challenge programmatically:

```php
$form['captcha'] = [
  '#type' => 'captcha',
  '#captcha_type' => 'default',          // or 'captcha/Math', 'image_captcha/Image'
  '#captcha_admin_mode' => FALSE,        // optional: render in admin/example mode
];
```

The element pulls the challenge from the matching `hook_captcha()` implementation, handles
session tracking (`captcha_sessions` table) and validation, and honours the global
persistence / whitelist settings.

### Theme hook
`captcha_theme()` registers the `captcha` theme hook using
`templates/captcha.html.twig` (render element `element`).

Per-challenge template suggestions are provided by
`captcha_theme_suggestions_captcha()`:
`captcha__<challenge>` (e.g. `captcha__math`, `captcha__image`), so you can override the
wrapper markup per challenge type from your theme.
