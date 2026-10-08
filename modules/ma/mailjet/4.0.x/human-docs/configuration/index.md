# Configuration

Mailjet needs two live credentials before it can send anything: your **API key**
and your **secret key**. These belong to your Mailjet account and grant full
access to send mail (and, with the marketing submodules, to your contact data),
so treat them exactly like passwords.

## Store your API credentials safely (recommended)

The API key and secret should **never** be committed to Git or left in exported
configuration. Keep them in an environment variable and surface them to Drupal
through a **Key** entity.

Under DDEV, save the values into DDEV's dotenv file and restart so the container
picks them up:

```bash
ddev dotenv set .ddev/.env --mailjet-api-key=<your-key> --mailjet-api-secret=<your-secret>
ddev restart
```

(The flag `--mailjet-api-key` becomes the environment variable
`MAILJET_API_KEY`. Never commit `.ddev/.env`.)

Then install the Key module if it isn't already enabled and create Key entities
that read those variables:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

You can then reference the Key entities from the Mailjet settings form rather
than pasting the raw secret into the database.

## Open the settings form

1. Log in as a user who can administer the Mailjet settings (an administrator by
   default).
2. Go to **Configuration → System → Mailjet**
   (`/admin/config/system/mailjet`).

## The API tab

Your credentials live on the **API** tab (`/admin/config/system/mailjet/api`):

- **API key** — the public API key from your Mailjet account.
- **Secret key** — the private secret paired with that key. This is the value
  you most want to keep out of plain configuration; point it at your Key entity
  or environment variable rather than typing the raw secret if your setup allows.

Save the form, then send a test email to confirm Drupal is authenticating with
Mailjet correctly.

## A note on the marketing submodules

If you enable the contact-list, subscription, or Commerce submodules, remember
that you are sending **personal data** (email addresses and any profile fields)
to Mailjet. Make sure you have a lawful basis for that processing and a processor
agreement in place, and configure double opt-in where your subscription flow
requires consent.

## Save

Click **Save configuration**. Changes take effect immediately.
