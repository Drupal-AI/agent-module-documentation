# Manager & programmatic resolution

Mailsystem replaces core's `plugin.manager.mail` service with
`Drupal\mailsystem\MailsystemManager` (extends `Drupal\Core\Mail\MailManager`) via
`MailsystemServiceProvider`. You rarely call it directly — core's `MailManagerInterface::mail()`
already routes through it — but the key pieces:

```php
// Core entry point; mailsystem decides the formatter/sender pair for $module/$key.
\Drupal::service('plugin.manager.mail')
  ->mail($module, $key, $to, $langcode, $params);
```

Constants on `MailsystemManager`:
- `MAILSYSTEM_TYPE_SENDING = 'sender'`
- `MAILSYSTEM_TYPE_FORMATTING = 'formatter'`
- `MAILSYSTEM_MODULES_CONFIG = 'modules'`

Behavior:
- `getInstance(['module' => …, 'key' => …])` reads `mailsystem.settings` and returns an
  `Adapter` that delegates `format()` to the configured **formatter** plugin and `mail()` to
  the configured **sender** plugin (falling back to `defaults`, then core `php_mail`).
- `Drupal\mailsystem\Adapter` is the composed `MailInterface` wrapping the two plugins.
- Mail theme is applied around formatting using the theme from `mailsystem_get_mail_theme()`
  (`setThemeManager()` / `setThemeInitialization()` are injected for this).

To expose a custom backend, register a normal core mail plugin
(`@Mail` annotation / `Drupal\Core\Annotation\Mail`, implementing `MailInterface`); it then
appears as a selectable formatter/sender on the settings form. There is no mailsystem-specific
plugin type to implement.
