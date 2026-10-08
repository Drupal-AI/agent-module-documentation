# Configure PHPMailer SMTP

Two settings forms, both gated by permission `administer phpmailer smtp settings`:

- **Transport** — `/admin/config/system/phpmailer-smtp` (route `phpmailer_smtp.settings`,
  config object `phpmailer_smtp.settings`).
- **Format** — `/admin/config/system/phpmailer-smtp/format` (route `phpmailer_smtp.format`,
  config object `phpmailer_smtp.format`).

## Activate it as the mail system

Enabling the module alone does **nothing** to routing — the module only *provides* a Mail
plugin (id `phpmailer_smtp`). You must point Drupal's mail system at it, one of two ways:

- **Mail System module** (`drupal/mailsystem`, the README's recommended route): install it,
  then under **Admin → Config → System → Mail System** choose *PHPMailer SMTP* as the
  **Sender** and **Formatter** for the Default Mail System (and/or per-module keys to send
  only some mail via SMTP).
- **Core config** — set `system.mail` `interface.default` to `phpmailer_smtp`, e.g.
  `drush config:set system.mail interface.default phpmailer_smtp`.

## `phpmailer_smtp.settings` keys (config/install defaults)

```yaml
smtp_host: 'localhost'            # SMTP server hostname
smtp_hostbackup: ''              # optional failover host (appended as ';host')
smtp_port: 25                    # 465 encouraged for SSL (RFC 8314)
smtp_protocol: ''               # '' | 'ssl' | 'tls' (maps to PHPMailer SMTPSecure)
smtp_username: ''
smtp_password: ''               # stored in config; use a secure workflow
smtp_hide_password: 0
smtp_authentication_type: 'basic_auth'  # 'basic_auth' or a PhpmailerOauth2 plugin id
smtp_fromname: ''               # default From name (falls back to site name)
smtp_always_replyto: 0          # add Reply-To from the From address
smtp_keepalive: 0               # reuse the SMTP connection across messages
smtp_debug: 0                   # verbose SMTP debug level
smtp_debug_log: 0               # also write debug dialogue to the logger
phpmailer_smtp_test: ''         # "send test email" recipient on the form
smtp_ssl_verify_peer: 1
smtp_ssl_verify_peer_name: 1
smtp_ssl_allow_self_signed: 0
smtp_envelope_sender_option: 'default'  # default | site_mail | from_address | other
smtp_envelope_sender: ''        # used when option is 'other'
smtp_ehlo_host: ''              # custom EHLO/HELO hostname
smtp_timeout: 30
```

- Encryption: set `smtp_protocol` to `ssl` or `tls`; the SSL verify_peer / verify_peer_name /
  allow_self_signed keys feed PHPMailer's `SMTPOptions['ssl']`. These are applied **only when
  `smtp_protocol` is non-empty**, and default to secure values (verify on, self-signed off).
  The plugin sets `SMTPAutoTLS = FALSE`, so a connection is encrypted only when you explicitly
  set a protocol — it will not opportunistically upgrade to STARTTLS on its own.
- Auth: `basic_auth` uses `smtp_username`/`smtp_password` (SMTPAuth is enabled only when both
  are non-empty). Any other value is treated as an **OAuth2 plugin id**: the plugin's
  `getAuthOptions()` builds a `PHPMailer\PHPMailer\OAuth`, and `AuthType` becomes `XOAUTH2`.
- `phpmailer_smtp.format`: `format` (`text_plain` default or `html`) and `force_html` (bool).
  HTML output renders through the themeable `phpmailer_smtp` template.
- Set via drush, e.g. `drush config:set phpmailer_smtp.settings smtp_host smtp.example.com`.
- Dev safety: add `$config['system.maintenance']['phpmailer_smtp_debug_email'] = 'me@example.com';`
  to settings.php to reroute all mail to one address.

## OAuth2 extension point

The module defines a `PhpmailerOauth2` plugin type (manager `plugin.manager.phpmailer_oauth2`,
plugins in `Plugin/PhpmailerOauth2`, discovered via the `PhpmailerOauth2` attribute or legacy
annotation). Extend
`Drupal\phpmailer_smtp\Plugin\PhpmailerOauth2\PhpmailerOauth2PluginBase` and return the
PHPMailer OAuth options from `getAuthOptions()`; the `drupal/phpmailer_oauth2` module ships an
Azure provider. Select the plugin by setting `smtp_authentication_type` to its plugin id.
