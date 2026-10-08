# Configuration

The base module's job is to connect Drupal to your Mailchimp account. That
connection is set up on a single settings form; the submodules add their own
screens on top of it.

## Open the settings form

1. Log in as a user with the **Administer mailchimp** permission.
2. Go to **Configuration → Web services → Mailchimp**
   (`/admin/config/services/mailchimp`).

## Connecting your account

You can authenticate two ways:

- **OAuth** (recommended) — leave **Use OAuth** enabled and complete the flow on
  the dedicated OAuth form at `/admin/config/services/mailchimp/oauth`. This is
  preferred because no long‑lived API key is stored on the site.
- **API key** — turn OAuth off and paste your Mailchimp **API key** into the
  field. The datacenter suffix on the key (for example `-us13`) automatically
  selects the correct Mailchimp region, so there is nothing else to set.

> **Keep the secret out of exported config.** Store the API key or OAuth
> credentials in an environment variable or a Key entity, not in committed
> configuration.

## Settings, field by field

- **API key** — your Mailchimp API key, used when OAuth is off.
- **Use OAuth** — authenticate via OAuth instead of a stored API key (on by
  default).
- **Domain** — the website domain used for authentication and Mailchimp Connected
  Sites.
- **API timeout** — how long, in seconds, to wait on an API request before giving
  up (default `10`).
- **Cron** — when enabled, subscription operations are queued and processed on
  cron rather than immediately, which helps respect Mailchimp's API rate limits.
- **Batch limit** — the maximum number of operations processed per batch or cron
  run (default `100`).
- **Test mode** — simulate sends without making live API calls. Turn this on
  during development so you do not touch your real audience.
- **Connected Sites** options — enable/identify the site for Mailchimp Connected
  Sites, and list the paths it applies to.
- **Webhook hash** — a secret hash that validates incoming calls to the
  `/mailchimp/webhook/{hash}` endpoint, so only Mailchimp can post subscribe /
  unsubscribe / profile updates back to your site.
- **Double opt‑in message** — the message shown to a user when a double opt‑in
  confirmation email has been sent (for example "Please check your email…").

## After connecting

With the account connected, enable the submodule for the feature you want (see
[Installation](../installation/index.md)) and configure it in its own UI —
signup forms, campaigns, or audience subscription fields. If you enabled **Cron**,
remember that cron must run regularly for queued subscription operations to be
processed; you can also trigger a run manually with `drush mailchimp:cron`.
