# Brevo Contact Sync — manual setup guide

**Brevo Contact Sync** (`brevo_contact_sync`) keeps your Drupal users in sync
with contacts in Brevo (the email-marketing platform formerly known as
Sendinblue). It pushes user data to Brevo contacts and keeps them updated through
the Brevo/Sendinblue API, so your site's user base stays aligned with the contact
lists you use for email marketing.

Two things follow from what it does. First, it sends user data to an external
service, so the privacy posture of that data — what you disclose to users, and any
consent you rely on — extends to Brevo. Second, it needs API credentials to talk
to Brevo, and it does not manage those itself: it depends on the **`sendinblue_api`**
module, which holds the API key. Keep that key out of committed config and code —
store it in an environment variable and reference it there.

It provides its own permissions and supports Drupal 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (the `sendinblue_api`
   module), installing with Composer, and enabling the module.

## Where it lives in the admin menu

The Brevo API credential is configured in the **`sendinblue_api`** module, not in
this one. Brevo Contact Sync provides its own permissions to control who may
manage the synchronization; grant them to trusted administrators.

## How to use it

The order of operations is: install the `sendinblue_api` module and give it your
Brevo API key (stored as a secret — see below), then enable Brevo Contact Sync.
Once the credential is in place, the module synchronizes Drupal users to Brevo
contacts, pushing their data and keeping the contacts updated as users change.

### Handling the Brevo API key as a secret

Because the key is held by `sendinblue_api`, configure it there, but the secret
handling is the same as for any external API credential. With DDEV, store the
value in an environment variable rather than in config:

```bash
ddev dotenv set .ddev/.env --brevo-api-key='<your-brevo-api-key>'
ddev restart
```

Then reference `BREVO_API_KEY` from the `sendinblue_api` configuration (via a Key
entity where it supports one, or `getenv('BREVO_API_KEY')`), and never commit the
value to version control.
