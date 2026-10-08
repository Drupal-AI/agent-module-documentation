# Configure Symfony Mailer Lite

## 1. Assign the mailer (required)
It only sends mail once selected in **Mail System** (`/admin/config/system/mailsystem`,
mailsystem module). Set Symfony Mailer Lite as the default *Formatter* and/or *Sender*, sitewide
or per module/key.

## 2. Transports (config entities)
`/admin/config/system/symfony-mailer-lite/transport` (route
`entity.symfony_mailer_lite_transport.collection`). Add/edit/delete transports and pick the
default. A `native` transport is installed by default
(`config/install/symfony_mailer_lite.symfony_mailer_lite_transport.native.yml`). Types come from
the transport plugins — see [../plugins/transport.md](../plugins/transport.md). Set default via
`.../transport/{id}/set-default` (CSRF-protected).

## 3. Message settings
`/admin/config/symfony-mailer-lite/message-settings` (`MessageSettingsForm`, config
`symfony_mailer_lite.message` / `symfony_mailer_lite.settings`) — character set and formatting
options. Available charsets come from `symfony_mailer_lite_get_character_set_options()`.

## 4. Test
`/admin/config/system/symfony-mailer-lite/test` (`TestEmailForm`) sends a sample HTML email to
confirm setup (uses `hook_mail()` key `test`).

## Custom sendmail command
The sendmail transport rejects arbitrary commands unless allow-listed in `settings.php`:
```php
$settings['mailer_sendmail_commands'] = ['/usr/sbin/sendmail -t'];
```

All the above require the `administer symfony_mailer_lite configuration` permission. Provides
config schema (`config/schema/symfony_mailer_lite.schema.yml`), so all config is exportable.
