# Configure — settings & email override

Source: `src/Controller/SimpleMailSettingsController.php` (a `ConfigFormBase`), `simple_mail.routing.yml`,
`simple_mail.module`.

## Route & permission

`simple_mail.config` → `/admin/config/system/simple_mail` (menu link under *Configuration › System*),
required permission `administer site configuration`.

## Config object `simple_mail.settings`

| Key | Form field | Effect |
|---|---|---|
| `queue_enabled` | Simple Mail Queue (select Disabled=0 / Enabled=1) | When 0, `simple_mail_queue()` returns FALSE (no queueing); when 1, messages are queued |
| `override` | E-mail override address | If non-empty, `hook_mail_alter()` rewrites the `to` of **every** outgoing site email to this address |

There is no config schema file; values are plain config.

## Email override (staging/dev safety)

```php
// simple_mail_mail_alter()
$override_email = \Drupal::config('simple_mail.settings')->get('override');
if (!empty($override_email)) {
  $message['to'] = $override_email;
}
```

This applies to **all** mail on the site (not just Simple Mail's own sends), so it is a global capture of
outbound email — set it on non-production environments to avoid emailing real recipients, and leave it
empty in production.

## Mail backend

The `simple_mail` mail plugin (`src/Plugin/Mail/SimpleMail.php`) extends core `PhpMail` and overrides
`format()` to `implode` the body array and `MailFormatHelper::wrapMail()` it. `simple_mail_mail()` sets
`Content-Type: text/html`. To route a mail key through this backend, assign it in
`system.mail`/Mail System config (the module does not auto-register itself as the site default).
