<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure PHPMailer SMTP

Two settings forms, both gated by permission `administer phpmailer smtp settings`
(`phpmailer_smtp.routing.yml`):

- **Transport** — `/admin/config/system/phpmailer-smtp` (route `phpmailer_smtp.settings`,
  `SettingsForm`, config object `phpmailer_smtp.settings`).
- **Format** — `/admin/config/system/phpmailer-smtp/format` (route `phpmailer_smtp.format`,
  `FormatForm`, config object `phpmailer_smtp.format`).

![PHPMailer SMTP transport settings form](../../../../../../../screenshots/phpmailer_smtp/2.4.x/settings-form.png)

## Install / requirements

`composer require drupal/phpmailer_smtp` (pulls `phpmailer/phpmailer:^7.1.1`), then enable.
`hook_requirements()` (`phpmailer_smtp.install`) reports an error unless the installed PHPMailer
library is **7.1.1 or newer** (`$mail::VERSION`). Ludwig is also supported for non-Composer
installs. No hook_install runs; defaults come from `config/install/*.yml`.

## Activate it as the mail system

Enabling the module alone does **nothing** to routing — it only *provides* a Mail plugin
(id `phpmailer_smtp`). Point Drupal's mail system at it, one of two ways:

- **Mail System module** (`drupal/mailsystem`, the README's recommended route): install it,
  then under **Admin → Config → System → Mail System** choose *PHPMailer SMTP* as the
  **Sender** and **Formatter** for the Default Mail System (and/or per-module keys to send
  only some mail via SMTP).
- **Core config** — set `system.mail` `interface.default` to `phpmailer_smtp`, e.g.
  `drush config:set system.mail interface.default phpmailer_smtp`.

## `phpmailer_smtp.settings` keys (config/install defaults)

```yaml
smtp_host: 'localhost'            # primary SMTP server hostname (form-required)
smtp_hostbackup: ''              # optional failover host (appended to Host as ';host')
smtp_port: 25                    # form-required; 465 encouraged for SSL
smtp_protocol: ''               # '' None | 'ssl' SSL/TLS | 'tls' STARTTLS -> PHPMailer SMTPSecure
smtp_username: ''
smtp_password: ''               # stored in the config object (see notes)
smtp_hide_password: 0           # once set, the plain textfield becomes a password field
smtp_authentication_type: 'basic_auth'  # 'basic_auth' or a PhpmailerOauth2 plugin id
smtp_fromname: ''               # default From name (falls back to system.site name)
smtp_always_replyto: 0          # add Reply-To from the From address if none set
smtp_keepalive: 0               # reuse the SMTP connection across messages in a request
smtp_debug: 0                   # 0 off | 1 errors | 2 server responses | 4 full communication
smtp_debug_log: 0               # also write captured debug dialogue to the dblog channel
phpmailer_smtp_test: ''         # "send test email" recipient field on the form
smtp_ssl_verify_peer: 1
smtp_ssl_verify_peer_name: 1
smtp_ssl_allow_self_signed: 0
smtp_envelope_sender_option: 'default'  # default | site_mail | from_address | other
smtp_envelope_sender: ''        # email, used when option is 'other'
smtp_ehlo_host: ''              # custom EHLO/HELO hostname (else PHPMailer decides)
smtp_timeout: 30                # seconds
```

## Credentials — how they are actually sourced/stored

- **Basic auth:** `smtp_username` and `smtp_password` are read straight from the
  `phpmailer_smtp.settings` config object (`PhpMailerSmtp::smtpInit()` → `$this->Username` /
  `$this->Password`). SMTP auth is enabled (`SMTPAuth = TRUE`) only when *both* are non-empty.
  The module does **not** read env vars, a Key entity, or settings.php for the password — it is
  a plain config value. For a hardened deployment, override it outside config yourself
  (settings.php `$config['phpmailer_smtp.settings']['smtp_password']`, or the Key module's
  config override). The `SettingsForm` only persists `smtp_password` when the submitted value is
  non-empty, and a "Delete password" checkbox clears it.
- **OAuth2:** `smtp_authentication_type` holds a `PhpmailerOauth2` plugin id (anything other
  than `basic_auth`). The module stores no tokens/client-secret itself — the selected plugin's
  `getAuthOptions()` supplies the `PHPMailer\PHPMailer\OAuth` options and `AuthType` becomes
  `XOAUTH2`. See [../plugins/oauth2.md](../plugins/oauth2.md).

## TLS / encryption posture

- `smtp_protocol` maps to PHPMailer `SMTPSecure`: `''` = no encryption (cleartext), `ssl` =
  implicit SSL/TLS (port 465), `tls` = STARTTLS (port 587). Default install value is `''`.
- `smtpInit()` sets `SMTPAutoTLS = FALSE`, so PHPMailer will **not** opportunistically upgrade a
  plaintext connection — encryption happens only when a protocol is explicitly chosen.
- When a protocol is set, `SMTPOptions['ssl']` is populated from the three SSL keys:
  `verify_peer` (default 1), `verify_peer_name` (default 1), `allow_self_signed` (default 0) —
  i.e. **certificate verification is enforced by default**; the "Advanced SSL settings" fieldset
  lets an admin relax these (and warns that doing so may make the connection insecure).
- If PHP lacks OpenSSL (`openssl_open` missing), the protocol select is disabled and forced to
  `''`.

## Format, attachments, envelope

- `phpmailer_smtp.format`: `format` (`text_plain` default or `html`) and `force_html` (bool).
  `format()` honours a message `Content-Type: text/plain` unless `force_html` is on; HTML output
  renders through the `#theme => 'phpmailer_smtp'` template (override via
  `phpmailer_smtp__MODULE[__KEY]` suggestions), then `msgHTML()` inlines images.
- Attachments come from `$message['params']['files']` or `['attachments']` (each item needs a
  `filepath` — `public://` is resolved via the file system — or `filecontent`).
- Envelope sender (SMTP `MAIL FROM`) is chosen by `smtp_envelope_sender_option`: `default`
  (message from), `site_mail`, `from_address` (From header), or `other` (`smtp_envelope_sender`).

## Operating notes

- Set via drush, e.g. `drush config:set phpmailer_smtp.settings smtp_host smtp.example.com`.
- Dev safety: `$config['system.maintenance']['phpmailer_smtp_debug_email'] = 'me@example.com';`
  in settings.php reroutes every message to that one address (`PhpMailerSmtp::mail()`).
- "Test configuration" on the form sends a message to the entered address via the plugin and
  links to dblog (if enabled) for errors.
- `smtp_debug` is a troubleshooting aid only — leave it `0` in production; captured SMTP dialogue
  is shown to the user via the messenger and, with `smtp_debug_log`, written to the
  `phpmailer_smtp` log channel.
