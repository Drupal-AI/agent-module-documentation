# htmlmail — API

No custom services are registered (no `*.services.yml`); the API surface is the `@Mail` plugin,
a static helper class, and Drupal hooks. No Drush commands.

## Mail plugin

`Drupal\htmlmail\Plugin\Mail\HtmlMailSystem` — `@Mail(id = "htmlmail", label = "HTML Mail mailer")`,
implements `MailInterface` + `ContainerFactoryPluginInterface`. Key methods:

- `format(array $message)` — collapses the body, themes it via the `htmlmail` theme hook
  (`HtmlMailHelper::getThemeNames()`), optionally runs Echo, then the configured `postfilter`
  (`check_markup()`), builds a plaintext alternative (`MailFormatHelper::htmlToText()`), and
  honors the recipient plaintext preference / `html_with_plain`.
- `mail(array $message)` — sends the formatted message.
- `formatMailMime()` / `txtHeaders()` — used when `use_mail_mime` is on (PEAR `\Mail_mime`,
  via `Drupal\htmlmail\Utility\HtmlMailMime`); supports `params['attachments']`.

You normally do not call the plugin directly — send mail the standard way and let Mail System
route it here:

```php
\Drupal::service('plugin.manager.mail')
  ->mail('my_module', 'my_key', $to, $langcode, $params);
```

`htmlmail_mail()` (hook_mail) maps `$params['subject']`, `$params['body']`, and optional
`$params['headers']` onto the message.

## Helper: `Drupal\htmlmail\Helper\HtmlMailHelper` (static)

- `getAllowedThemes()` — assoc array of enabled themes (`'' => 'No theme'`) for the settings select.
- `getSelectedTheme(array &$message = [])` — theme from `$message['theme']` or `htmlmail.settings:theme`, validated against allowed themes.
- `getThemeNames(array $message)` — `['htmlmail__{module}', 'htmlmail__{module}__{key}', 'htmlmail']` for the `#theme` array.
- `htmlMailIsAllowed(string $email)` — FALSE if that recipient set the plaintext-only preference.
- `allowUserAccess()` — TRUE if current user has `choose htmlmail_plaintext` or `administer users`.
- Constants: `HTMLMAIL_MODULE_NAME = 'htmlmail'`, `HTMLMAIL_USER_DATA_NAME = 'htmlmail_plaintext'`.

## Per-user plaintext preference

`htmlmail_form_user_form_alter()` adds a "Plaintext-only emails" checkbox to the user account
form (shown only when `allowUserAccess()`), stored in `user.data` under module `htmlmail`, key
`htmlmail_plaintext`. `format()` respects it via `htmlMailIsAllowed()`.

## Hooks the module implements (for reference / extension points)

- `hook_theme` (`htmlmail_theme`), `hook_theme_suggestions_htmlmail_alter`, `template_preprocess_htmlmail`.
- Extend templates from other modules with `MODULENAME_preprocess_htmlmail(&$variables)`.
- `hook_mail`, `hook_form_user_form_alter`, `hook_help`.
