# Configuration

Setting up Mailjet API is a three-step process: enter your credentials, tune the
options, and then tell Drupal's Mail System to actually use the Mailjet mailer.
Access to the module's administration is gated by the **Administer Mailjet API**
(`administer mailjet api`) permission — grant it only to trusted administrators.

## Store your API credentials safely (recommended)

Your Mailjet **public API key** and **secret key** are live credentials that
grant the ability to send mail from your account. Keep them out of Git and
exported configuration by storing them in an environment variable and surfacing
them through a **Key** entity.

Under DDEV:

```bash
ddev dotenv set .ddev/.env --mailjet-api-key=<your-key> --mailjet-api-secret=<your-secret>
ddev restart
```

(The flag `--mailjet-api-key` becomes the environment variable
`MAILJET_API_KEY`. Never commit `.ddev/.env`.) Then install and enable the Key
module (`ddev composer require drupal/key && ddev drush en key -y`) and create
Key entities that read those variables, so the raw secret never lands in the
database.

## Enter the API keys and options

Open the Mailjet API settings form and fill in:

- **Public API key** — your Mailjet public key.
- **Secret key** — the paired private secret; prefer a Key entity or environment
  variable over pasting the raw value.

The form also exposes a few behaviour toggles you can enable as needed:

- **Cron** — send queued messages on cron runs.
- **Use theme key** — apply a theme when formatting the mail.
- **Sandbox mode** — let Mailjet accept and validate messages without actually
  delivering them; useful while testing.
- **Embed image** — inline images in the message.

Save the form.

## Point Mail System at the Mailjet mailer

Enabling this module does not by itself reroute your mail — you must tell Mail
System to use it:

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`).
2. Set the **Formatter** and/or **Sender** to **Mailjet API Mailer** — either
   globally (the site-wide default) or for a specific module or mail key if you
   only want certain messages to go through Mailjet.
3. Save.

## Test it

Use the module's **testing form** to send a message to yourself and confirm the
whole path — credentials, mailer selection, and delivery — is working before you
rely on it for production email.
