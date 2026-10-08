# Configuration

Getting Postmark working is two steps: tell Mail System to route mail to Postmark,
then enter your Postmark credentials.

## 1. Point Mail System at Postmark

Postmark only sends mail once the Mail System module hands messages to it. Go to
**Configuration → System → Mail System** (`/admin/config/system/mailsystem`) and
set the **Sender** (and, if you want Postmark to build the message too, the
**Formatter**) to **Postmark mailer**. You can do this site-wide, or only for a
specific module key (for example just Commerce) while everything else stays on the
default mailer.

## 2. Enter your Postmark settings

Go to **Configuration → System → Postmark** (`/admin/config/mail/postmark`,
requires the restricted **Administer Postmark** permission):

- **API token** *(required)* — your Postmark **Server** API token. This is what the
  module authenticates to Postmark with.
- **Sender signature** *(required)* — a verified Postmark Sender Signature email
  address. Postmark requires every message to come from a verified signature, so
  this is used as the **From** address on every send, regardless of the message's
  own From.
- **Debug mode** — turns on debug logging and the debug-email redirect (below).
- **Debug email** — when debug mode is on, **all** outgoing mail is delivered to
  this one address instead of its real recipient. Ideal for staging and
  development.
- **No-send test mode** — reports success *without* actually calling Postmark, so
  no Postmark credit is spent. Useful for verifying wiring without sending.
- **Text format** *(optional)* — if set, the email body is run through this
  Drupal text format before sending.

The form also has a **Test email** field: enter an address and, on save, Postmark
sends a one-off test message from your Sender Signature to that address so you can
confirm the whole chain works.

Click **Save configuration**.

## Keep your API token out of exported config

The module doesn't ship a config schema, so your token would otherwise sit in
exported configuration. The recommended pattern is to keep it in an environment
variable and override it in `settings.php`:

```php
$config['postmark.settings']['postmark_api_key'] = getenv('POSTMARK_API_KEY');
```

You can also set values from the command line if you prefer:

```bash
drush config:set postmark.settings postmark_api_key   'server-token-here' -y
drush config:set postmark.settings postmark_sender_signature 'noreply@example.com' -y
```

## Troubleshooting

- **Sends fail with a signature error** — the From/Sender Signature must exactly
  match a *verified* signature in your Postmark account. Failures are logged to the
  `postmark` logger channel (Reports → Recent log messages).
- **Nothing is going through Postmark** — double-check that Mail System's Sender is
  set to *Postmark mailer* for the relevant module key.
- **Testing without spending credits** — turn on **No-send test mode**, or use
  **Debug mode** with a **Debug email** to catch everything in one inbox.
