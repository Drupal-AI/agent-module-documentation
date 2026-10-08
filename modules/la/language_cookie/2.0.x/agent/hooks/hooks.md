# Hooks invited by Language Cookie

Source: `language_cookie.api.php`.

## `hook_language_cookie_alter(Cookie &$cookie)`

Alter the outgoing language cookie just before it is attached to the response. `$cookie` is a
`Symfony\Component\HttpFoundation\Cookie` (passed by reference). Invoked at the end of
`LanguageCookieSubscriber::setLanguageCookie()` via `$this->moduleHandler->alter('language_cookie', $cookie)`.

```php
use Symfony\Component\HttpFoundation\Cookie;

function my_module_language_cookie_alter(Cookie &$cookie) {
  $langcode = \Drupal::languageManager()->getCurrentLanguage()->getId();
  // Replace the cookie entirely (name/value/attributes).
  $cookie = Cookie::create('my_language_cookie', $langcode);
}
```

Use it to rename the cookie, change its value, or adjust attributes beyond the admin settings.

## `hook_language_cookie_condition_info_alter(array &$plugins)`

Modify the discovered `LanguageCookieCondition` plugin definitions (by reference) after other modules
declare them — e.g. rename a condition or change its weight/ordering. Invoked by the condition
manager's `alterInfo('language_cookie_condition_info')`.

```php
function my_module_language_cookie_condition_info_alter(array &$plugins) {
  $plugins['blacklisted_paths']['name'] = t('Skip on these paths');
  // $plugins['some_plugin']['weight'] = -10;
}
```

To add (not just alter) a condition, ship a plugin class instead — see
[../plugins/conditions.md](../plugins/conditions.md).
