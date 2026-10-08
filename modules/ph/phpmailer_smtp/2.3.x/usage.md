PHPMailer SMTP routes Drupal's outgoing mail through an external SMTP server using the modern `phpmailer/phpmailer` library, exposed as a core Mail (`MailInterface`) plugin.

---

PHPMailer SMTP provides a single Drupal Mail plugin — `PhpMailerSmtp` (plugin id `phpmailer_smtp`) — that extends the `PHPMailer\PHPMailer\PHPMailer` library class and implements Drupal's `MailInterface` (`format()` + `mail()`). Unlike the older `smtp` module, it does **not** auto-swap Drupal's mail system when enabled: you select "PHPMailer SMTP" as the Sender and/or Formatter through the Mail System (`mailsystem`) module, or point core's `system.mail` `interface` config at the `phpmailer_smtp` plugin id. Connection details live in the `phpmailer_smtp.settings` config object edited at Admin → Configuration → System → PHPMailer SMTP (`/admin/config/system/phpmailer-smtp`, route `phpmailer_smtp.settings`): SMTP host (plus optional backup host), port, protocol/encryption (`ssl`/`tls`), timeout, keep-alive, SSL peer-verification options, envelope-sender handling, EHLO host, and debug logging. Authentication is pluggable via `smtp_authentication_type`: `basic_auth` uses a username/password, or an OAuth2 plugin id engages the module's own `PhpmailerOauth2` plugin type (manager `plugin.manager.phpmailer_oauth2`) so contrib like PHPMailer OAuth2 can authenticate with XOAUTH2. A second form, PHPMailer SMTP message format (route `phpmailer_smtp.format`, config `phpmailer_smtp.format`), controls plain-text vs HTML output (with a `force_html` override and a themeable `phpmailer_smtp` template). The plugin also handles file attachments (from `params['files']`/`params['attachments']`), CC/BCC/Reply-To headers, per-message content-type detection, and captures verbose SMTP debug output to Drupal's logger. A single permission, `administer phpmailer smtp settings`, gates both config forms, and a `settings.php` override (`$config['system.maintenance']['phpmailer_smtp_debug_email']`) can reroute all mail to one address for safe development.

---

- Send all Drupal transactional email through an external SMTP relay (SendGrid, Mailgun, Amazon SES, Postmark, etc.).
- Use Gmail / Google Workspace as the SMTP server on port 465 with SSL.
- Authenticate to the SMTP server with a username and password (`basic_auth`).
- Authenticate with OAuth2 / XOAUTH2 instead of a password via a `PhpmailerOauth2` plugin.
- Configure a primary SMTP host plus a backup host for failover.
- Choose SSL or TLS encryption for the SMTP connection.
- Set a custom SMTP port (default 25; 465 encouraged for SSL).
- Tune the connection timeout for slow mail servers.
- Keep the SMTP connection alive across multiple messages in one request (`smtp_keepalive`).
- Relax or enforce SSL certificate checks (verify peer, verify peer name, allow self-signed).
- Set a default "From" name applied to outgoing mail, falling back to the site name.
- Always add a Reply-To header from the From address (helps with Gmail relaying).
- Control the SMTP envelope sender (site mail, the From address, or a fixed address).
- Set a custom EHLO/HELO hostname for the SMTP handshake.
- Send mail as HTML using a themeable `phpmailer_smtp` template, or force HTML for all mail.
- Honour a message's `text/plain` content-type and convert HTML bodies to plain text.
- Attach files to outgoing mail via `params['files']` or `params['attachments']`.
- Route only *some* mail keys through SMTP by assigning the plugin per-module in Mail System.
- Reroute every outgoing email to one debug address during development (`phpmailer_smtp_debug_email`).
- Log verbose SMTP server dialogue for troubleshooting delivery failures.
- Replace the legacy `smtp` module with a build tracking the current PHPMailer 6 release.
- Install without Composer using the Ludwig library-download workflow.
- Restrict who can edit SMTP credentials with the `administer phpmailer smtp settings` permission.
- Deploy SMTP connection settings as exportable configuration between environments.
- Send a test email from the settings form to verify connectivity.
