# Configuration

Configuring PHPMailer SMTP is two jobs: filling in your SMTP server details on the
module's forms, and telling Drupal to actually route mail through it.

## 1. Activate it as the mail system

Because enabling the module doesn't change mail routing on its own, do this first
(or last — but don't skip it). With the **Mail System** module installed, go to
**Configuration → System → Mail System**
(`/admin/config/system/mailsystem`) and, under **Default Mail System**, choose:

- **Sender** → *PHPMailer SMTP*
- **Formatter** → *PHPMailer SMTP*

You can also set per-module keys if you only want some of Drupal's mail to go via
SMTP. (Advanced alternative: set core's `system.mail` `interface.default` to
`phpmailer_smtp` directly, e.g.
`drush config:set system.mail interface.default phpmailer_smtp`.)

## 2. SMTP transport settings

Open **Configuration → System → PHPMailer SMTP**
(`/admin/config/system/phpmailer-smtp`). This edits the `phpmailer_smtp.settings`
config object.

### Server

- **SMTP host** — your mail server's hostname (default `localhost`).
- **Backup host** — an optional failover host.
- **SMTP port** — default `25`; **465** is encouraged for fully-encrypted SSL/TLS.
- **Encryption protocol** — none, **SSL/TLS**, or **STARTTLS**. Port 465 uses
  implicit SSL/TLS (nothing is ever sent in the clear) and is the most secure
  choice. STARTTLS goes with port 587 and upgrades a plain-text connection, which
  is slightly less secure. **Important:** encryption is applied *only when you
  select a protocol* — the module deliberately does not opportunistically upgrade
  to STARTTLS on its own, so leaving the protocol empty means an unencrypted
  connection.

### SSL verification

When a protocol is set, three options control certificate checking (all default
to the secure choice): **verify peer**, **verify peer name**, and **allow
self-signed**. Leave verification on unless you have a specific reason (such as an
internal server with a self-signed certificate) to relax it.

### Authentication

- **Authentication type** — **Basic auth** uses the username and password below;
  any other choice selects an **OAuth2 plugin** (see below).
- **Username** / **Password** — your SMTP credentials. Authentication is only sent
  when both are filled in. Note the password is stored in configuration by
  default — see "Keeping credentials secure" below.
- **Hide password** — masks the password field in the form.

### Sending identity and behavior

- **From name** — the default "From" display name (falls back to the site name).
- **Always add Reply-To** — adds a Reply-To header from the From address.
- **Envelope sender** — choose which address is used as the SMTP envelope sender
  (default, the site email, the message's From address, or a custom "other"
  address you type in).
- **EHLO/HELO host** — a custom hostname to present to the server, if required.
- **Keep-alive** — reuse a single SMTP connection across multiple messages.
- **Timeout** — connection timeout in seconds (default 30).

### Debugging and testing

- **Debug level** and **Log debug output** — verbose SMTP dialogue for
  troubleshooting; optionally also written to the log.
- **Send test email** — enter a recipient to fire off a test message and confirm
  the connection works.

## 3. Email format

Open **Configuration → System → PHPMailer SMTP → Format**
(`/admin/config/system/phpmailer-smtp/format`, config object
`phpmailer_smtp.format`):

- **Format** — **Plain text** (default) or **HTML**.
- **Force HTML** — force all outgoing mail through the HTML template.

## Keeping credentials secure

By default the SMTP password lives in configuration, which is easy to leak through
a config export. For production, prefer one of these:

- **A settings.php / settings.local.php override** that pulls the credentials from
  a secrets service (for example AWS Secrets Manager) — the module's docs call
  this the simplest secure option.
- **The Key module**, which can supply any configuration value from a more secure
  provider. On DDEV you can put the secret in an environment variable with
  `ddev dotenv set .ddev/.env --smtp-password=<value>` (never commit `.ddev/.env`),
  restart, and back it with an `env`-provider Key entity.

## OAuth2 authentication

Instead of a username and password, PHPMailer SMTP can authenticate with OAuth2.
This is done through small plugins (the `PhpmailerOauth2` plugin type); the
separate **PHPMailer OAuth2** and **PHPMailer Azure OAuth2** modules provide
ready-made providers (for example for Microsoft Azure). To use one, set the
**Authentication type** to the provider's plugin id rather than Basic auth.

## Save

Click **Save configuration** on each form. Send a test email to confirm the whole
chain — module → Mail System routing → SMTP server — is working end to end.
