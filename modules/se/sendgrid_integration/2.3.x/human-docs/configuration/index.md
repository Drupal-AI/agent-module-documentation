# Configuration

Getting SendGrid live is three steps: **enter your API key** (and tracking
options), **activate SendGrid as the mail system** in Mailsystem, and **send a test
email** to confirm it works.

## 1. Settings form — API key and tracking

Go to **Configuration → System → SendGrid** (`/admin/config/services/sendgrid`).
This form requires the **Administer SendGrid settings** permission. The settings:

| Setting | What it does |
|---|---|
| **API Secret Key** | Your SendGrid API secret — or, when the Key module is enabled, the Key entity you select here. |
| **Open tracking** | Turn on SendGrid open tracking for outgoing mail. |
| **Click tracking** | Turn on SendGrid click tracking for outgoing mail. |
| **Test defaults** | Values that pre‑fill the test form (recipient, subject, body, from/to names, reply‑to). |

Click **Save configuration** when done. These settings export/deploy as normal
config with `drush config:export`.

### Setting the API key — three ways

Pick whichever suits your security needs:

1. **Plain config** (no Key module) — paste the SendGrid secret straight into the
   **API Secret Key** field. It is stored as‑is in config.
2. **Key module** — if the Key module is enabled, create a Key (type
   *Authentication*, using the *Configuration* or *Environment* provider), then
   select it in the settings form. **When the Key module is on, you must use a
   Key** — the plain‑value path is skipped.
3. **settings.php** (keeps the secret out of the repo and out of the database
   export) — with plain config:

   ```php
   $config['sendgrid_integration.settings']['apikey'] = 'THEAPIKEY';
   ```

   or, with the Key module:

   ```php
   $config['key.key.MYKEY']['key_provider_settings']['key_value'] = 'THEAPIKEY';
   ```

> On DDEV, store the secret in an environment variable rather than committing it —
> `ddev dotenv set .ddev/.env --sendgrid-api-key=<value>` then `ddev restart` — and
> point a Key entity (env provider) or `settings.php` at that variable.

## 2. Activate SendGrid as the mail system

This module only *provides* the SendGrid mail plugin; it does not take over mail by
itself. Use the **Mailsystem** module to switch:

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`).
2. Set **Sendgrid Integration** as the site‑wide default **sender** (the "Formatter
   and sender" for all mail), or set it only for a specific module if you want just
   that module's mail to go through SendGrid.
3. To send **HTML** email, set the *formatter* to **Mimemail** — SendGrid
   Integration's own formatter only concatenates the body parts.

Save the Mailsystem form.

## 3. Send a test email

Go to **Configuration → System → SendGrid → Test**
(`/admin/config/services/sendgrid/test`), fill in a recipient (the test defaults
you set earlier pre‑fill it), and send. A successful send is logged at info level —
check **Reports → Recent log messages** if you need to confirm.

## Good to know

- **Categories** — every message is automatically tagged with SendGrid categories
  (site name, sending module, message key) so you can filter and report in the
  SendGrid dashboard.
- **Automatic retries** — if SendGrid returns a retryable error, the message is
  queued and retried on the next cron run (within a 60‑minute window).
- **Spam‑check bypass** — password‑reset and Drupal Commerce messages automatically
  bypass SendGrid's spam checks so they aren't delayed.
- **Reports** — enable the `sendgrid_integration_reports` sub‑module for an
  in‑Drupal statistics dashboard.
