# Configuration

Brevo Webform Handler has no global settings page. You configure it per Webform,
by adding it as a **handler** on the form you want to feed into Brevo.

## Add the handler to a Webform

1. Go to **Structure → Webforms** and edit the form you want (a signup or lead
   form is the usual case).
2. Open **Settings → Emails / Handlers**.
3. Click **Add handler** and choose the **Brevo** handler.

## Configure the handler

In the handler's settings you connect the form to Brevo:

- **API key** — your Brevo (Sendinblue) API key, used to authenticate to the
  Brevo Contacts API. Treat this as a secret (see below).
- **Field mapping** — map the Webform's fields (email, name, and any other
  attributes) to the corresponding Brevo contact fields, so a submission becomes a
  well-formed contact.
- **Target list** — the Brevo contact list the new/updated contact should belong
  to.

Save the handler. From then on, each matching submission is sent to Brevo as a
contact.

## Handle the API key as a secret

Do not commit the Brevo API key to configuration or code. Keep it in an
environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --brevo-api-key='<your-brevo-api-key>'
ddev restart
```

The flag `--brevo-api-key` becomes the variable `BREVO_API_KEY` inside the web
container. Confirm it is present without printing it:

```bash
ddev exec 'test -n "$BREVO_API_KEY"'   # exit status 0 means it is set
```

Where the handler accepts a Key entity, create one backed by that variable (via
the Key module) and select it, so the secret is read from the environment at
runtime rather than stored in exported config. If only a plain-text field is
available, at minimum keep the key out of any configuration you export and commit.

## Capture consent and disclose

The submission you forward is personal data going to an external marketing
service. Add a consent checkbox to the form and make sure your privacy notice
covers the transfer to Brevo, so only submissions where the user agreed become
marketing contacts.
