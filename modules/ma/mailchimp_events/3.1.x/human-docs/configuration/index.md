# Configuration

Configuring Mailchimp Events is really two things: making sure the underlying
**Mailchimp** connection is in place, and then defining the events you want to
send. It also involves sending behavioural data to a third party, so consent
matters.

## First, connect Mailchimp

Mailchimp Events does nothing on its own — it relies entirely on the base
**Mailchimp** module and **Mailchimp Lists**. Before configuring events:

1. Install and enable the base Mailchimp module (see
   [Installation](../installation/index.md)).
2. In the Mailchimp module's settings, provide your Mailchimp **API key** so the
   site can talk to your account.

### Store the API key as a secret

The API key is a credential — keep it out of plaintext configuration and version
control:

1. Save it into an environment variable with DDEV's dotenv command:

   ```bash
   ddev dotenv set .ddev/.env --mailchimp-api-key=YOUR_KEY_HERE
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Store it as a **Key** entity using the [Key](https://www.drupal.org/project/key)
   module's environment provider, and point the Mailchimp module at that key
   instead of pasting the value into a config field — this keeps the secret out of
   exported configuration.

## Define your events

With Mailchimp connected, use this module to define the **events** you want to
send — the on-site actions that should be recorded against a known user in
Mailchimp. These are managed as entities in the admin UI. Choose events that map
to the behaviour you actually want to target on (content viewed, an action
completed, and so on), then use Behavioral Targeting in Mailchimp to build
audiences from them.

## Privacy and consent — this sends behavioural data to Mailchimp

Tracking what identified users do and forwarding it to Mailchimp is **personal
data processing**. Before you rely on it:

- **Capture consent** for behavioural tracking and marketing where required.
- **Disclose** in your privacy policy that on-site activity for known users is
  sent to Mailchimp, and make sure it's compatible with regulations such as GDPR.
- **Confirm the scope** — only send the events you genuinely need, and check that
  no event carries information you don't intend to share.

## Permissions

The module provides its own permissions. Grant them only to trusted
administrators at **People → Permissions** (`/admin/people/permissions`).
