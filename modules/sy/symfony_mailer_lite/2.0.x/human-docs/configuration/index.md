# Configuration

Configuring Symfony Mailer Lite is a four‑step story: tell Drupal to use it,
choose how mail leaves the site (transports), tune the message formatting, and send
a test. Everything below requires the **Administer symfony_mailer_lite
configuration** permission, and all of it is exportable configuration.

## 1. Assign the mailer (required)

The module sends nothing until it is selected in **Mail System**:

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`) — this form is provided by the Mail System
   module.
2. Set **Symfony Mailer Lite** as the default **Formatter** and/or **Sender**. You
   can do this sitewide, or override it for specific modules and mail keys.

This is the step people most often miss — without it, your other settings have no
effect.

## 2. Transports

Transports decide *how* mail physically leaves the site. Manage them at
**Configuration → System → Symfony Mailer Lite**
(`/admin/config/system/symfony-mailer-lite/transport`). A **native** transport
(php.ini sendmail) is installed by default; you can add, edit, and delete
transports and choose which one is the default. The available types come from the
transport plugins:

- **Native** — uses the server's configured php.ini sendmail; no extra setup.
- **SMTP** — send through an external SMTP server (host, port, credentials).
- **Sendmail** — use the local sendmail binary.
- **Null** — discards mail without sending; ideal for development so you never mail
  real people.
- **DSN** — configure a transport directly from a raw Symfony Mailer DSN string.

Setting one as the default is CSRF‑protected via a dedicated action link.

## 3. Message settings

The message‑settings form (`/admin/config/symfony-mailer-lite/message-settings`)
controls formatting options such as the **character set / encoding** used for
outgoing mail. The available character sets are supplied by the module.

## 4. Send a test email

Confirm everything works from the test form at
`/admin/config/system/symfony-mailer-lite/test`, which sends a sample HTML email
using the module's own mail key. If it arrives correctly formatted, your setup is
good.

## Allow‑listing a custom sendmail command

For security, the Sendmail transport refuses arbitrary commands unless you
explicitly allow‑list them in `settings.php`:

```php
$settings['mailer_sendmail_commands'] = ['/usr/sbin/sendmail -t'];
```

Only add commands you trust — this is a deliberate guard against command injection.
