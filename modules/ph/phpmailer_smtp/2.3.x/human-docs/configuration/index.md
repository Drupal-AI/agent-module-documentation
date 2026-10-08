# Configuration

Configuring PHPMailer SMTP is two jobs: **activating** it as your site's mail
handler (the step people most often miss), and then **filling in** the connection
details for your SMTP provider.

## Step 1 — activate it as the mail system

Enabling the module by itself changes nothing about how mail is sent — it only
makes a "PHPMailer SMTP" option available. Turn it on in one of two ways:

- **With the Mail System module (recommended).** Install `drupal/mailsystem`, then
  go to **Configuration → System → Mail System**
  (`/admin/config/system/mailsystem`) and choose *PHPMailer SMTP* as the **Sender**
  (and, if you want it to build the message too, the **Formatter**) for the default
  mail system. You can also set it for individual modules if you only want *some*
  mail to go over SMTP.
- **With core configuration.** Point core's mail interface at the plugin, for
  example:

  ```bash
  drush config:set system.mail interface.default phpmailer_smtp
  ```

## Step 2 — the transport settings form

Go to **Configuration → System → PHPMailer SMTP**
(`/admin/config/system/phpmailer-smtp`). The fields are:

### Server connection

- **SMTP host** — your mail provider's server hostname (for example
  `smtp.sendgrid.net` or `smtp.gmail.com`).
- **Backup host** — an optional second host used for failover if the primary is
  unreachable.
- **SMTP port** — the port to connect on. The default is 25; use 465 for SSL.
- **Encryption protocol** — none, **SSL**, or **TLS**. Match this to what your
  provider requires (SSL commonly pairs with port 465).
- **Connection timeout** — how long (in seconds, default 30) to wait for the server
  before giving up. Increase it for slow mail servers.
- **Keep connection alive** — reuse a single SMTP connection for several messages
  in one request instead of reconnecting each time.
- **EHLO/HELO host** — a custom hostname to present during the SMTP handshake, if
  your provider expects a particular one.

### SSL certificate handling

When using SSL/TLS you can control how strictly the server's certificate is
checked:

- **Verify peer** and **Verify peer name** — on by default; keep them on for
  security.
- **Allow self‑signed certificates** — off by default; only enable this for a mail
  server using a self‑signed certificate.

### Authentication

- **Authentication type** — choose **Basic** (username and password) or an
  **OAuth2** method if you have an OAuth2 provider plugin installed (for example
  the companion PHPMailer OAuth2 module, which adds Azure).
- **Username** / **Password** — your SMTP credentials, used when authentication is
  set to Basic. Note these are stored in configuration, so use a secure deployment
  workflow and be careful about exporting them to a repository.

### Sender and reply handling

- **From name** — a default display name for outgoing mail; falls back to the site
  name if left blank.
- **Always add Reply‑To** — adds a Reply‑To header taken from the From address,
  which can help with providers such as Gmail.
- **Envelope sender** — which address to use as the SMTP envelope sender: the site
  mail address, the message's From address, or a fixed address you specify.

### Debugging

- **Debug level** and **Log debug output** — record the verbose back‑and‑forth with
  the SMTP server to Drupal's log, to help diagnose delivery problems. (Elevated
  debug output is only shown to users who hold the *Administer PHPMailer SMTP
  settings* permission.)
- **Send a test email** — enter a recipient address and save to send a test message
  and confirm the connection actually works.

Click **Save configuration** to apply. These settings are stored as configuration
and can be deployed between environments with `drush config:export` /
`config:import`.

## Step 3 — the message format form

A second form, under **Configuration → System → PHPMailer SMTP → Format**
(`/admin/config/system/phpmailer-smtp/format`), controls output format:

- **Format** — send as plain text (the default) or **HTML**.
- **Force HTML** — treat all outgoing mail as HTML even when a message asked for
  plain text.

HTML mail is rendered through a themeable `phpmailer_smtp` template you can
override in your theme.

## Development safety net

To keep test mail from reaching real recipients while developing, add this to
`settings.php` to reroute every outgoing email to a single address:

```php
$config['system.maintenance']['phpmailer_smtp_debug_email'] = 'me@example.com';
```
