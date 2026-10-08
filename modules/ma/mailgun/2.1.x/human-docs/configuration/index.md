# Configuration

Setting up Mailgun is three steps: enter your connection details, wire Mailgun in
as the site mailer through Mailsystem, and send a test email.

## Open the settings form

1. Log in as a user with the **Administer Mailgun** permission (grant it only to
   trusted administrators — it exposes the API key and can send mail).
2. Go to **Configuration → System → Mailgun**
   (`/admin/config/services/mailgun/settings`).

## Connection settings

- **API key** (`api_key`) — your Mailgun private API key. Store it securely rather
  than in plain config (see below).
- **API endpoint** (`api_endpoint`, default `https://api.mailgun.net`) — the
  Mailgun API base URL. Use the EU endpoint instead if your Mailgun account is in
  the EU region.
- **Working domain** (`working_domain`, default *derive from sender*) — the
  Mailgun sending domain. The default derives it from the From address; set a
  specific domain to force one.

## Behavior settings

- **Debug mode** (`debug_mode`, off) — log the full Mailgun API request and
  response for troubleshooting.
- **Test mode** (`test_mode`, off) — Mailgun accepts messages but does not
  actually deliver them (they are logged instead). Handy during development.
- **Track opens / Track clicks** (`tracking_opens`, `tracking_clicks`) — enable or
  disable open and click tracking, or leave it to the domain's own setting.
- **Tracking exceptions** (`tracking_exception`, default `user:password_reset`) —
  mail keys excluded from tracking, so sensitive mails like password resets aren't
  tracked.
- **Format filter** (`format_filter`, default *plain text*) — the text format used
  to render the message body; choose an HTML‑capable format to send HTML email.
- **Use queue** (`use_queue`, off) — queue outgoing mail and send it on cron
  instead of immediately, so mail sending doesn't slow page requests.
- **Use theme** (`use_theme`, off) — wrap emails in the site theme.
- **Tag by mail key** (`tagging_mailkey`, off) — tag outgoing messages by their
  Drupal mail key for Mailgun analytics.

Click **Save configuration**. You can also read and set these with Drush:

```bash
drush cget mailgun.settings use_queue
drush cset mailgun.settings test_mode true -y
drush cset mailgun.settings tracking_opens yes -y
```

## Store the API key securely

Do not commit the key to version control. Prefer an environment variable:

```bash
ddev dotenv set .ddev/.env --mailgun-api-key=<value>   # then: ddev restart
```

Then reference `getenv('MAILGUN_API_KEY')` from settings, or set
`mailgun.settings api_key` from the environment variable during deployment. Keep
`.ddev/.env` out of version control.

## Wire Mailgun in as the mailer

Mailgun does not take over mail delivery by itself — you select its Mail plugin
through the **Mailsystem** module:

1. Go to **Configuration → System → Mailsystem**
   (`/admin/config/system/mailsystem`).
2. Set the **sender** (and usually the **formatter**) to **Mailgun mail** for
   immediate sending, or **Mailgun queue mail** for queued/background sending —
   either globally under the defaults, or per module / mail key.

To route all mail through Mailgun immediately from the command line:

```bash
drush cset mailsystem.settings defaults.sender mailgun_mail -y
drush cset mailsystem.settings defaults.formatter mailgun_mail -y
```

If you use queued sending, remember that queued messages are delivered on cron
(or `drush queue:run mailgun_send_mail`).

## Send a test email

Go to **Configuration → System → Mailgun → Test Email**
(`/admin/config/services/mailgun/settings/test`) and send a trial message to
confirm your key, domain, and mailer wiring are all correct.
