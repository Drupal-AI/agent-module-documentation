# Configuration

Discord Notifications does nothing until you tell it where to post and what to
report. All of that lives on a single settings page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Administration → Configuration → System → Discord Notifications**, or
   navigate directly to `/admin/config/system/discord-notifications`.

## The settings

- **Discord webhook URL** — paste the incoming webhook URL you copied from Discord
  (**Server Settings → Integrations → Webhooks**). This is required; without it,
  nothing is sent. Keep it secret — anyone holding it can post to your channel.
- **Notification types** — a set of toggles letting you choose exactly which
  events get announced. The available categories are:
  - **Content** — new content created, content updated, content deleted.
  - **User activity** — new user registrations, user logins, users being blocked.
  - **System** — available Drupal core or module updates, and completed cron runs.
  - **Security** — failed login attempts and password‑reset requests.
  Enable only the ones your team actually wants to see, so the channel stays
  useful rather than noisy.
- **Mentions** — optionally have notifications ping the channel using **@here** or
  **@everyone**. Use this sparingly; reserve it for events that genuinely warrant
  interrupting everyone.

Click **Save configuration** when done.

## Keeping the webhook out of exported config

The webhook URL is a secret, so avoid committing it via `config:export`. The
recommended pattern is to store it in an environment variable and reference it
through a **Key** entity, so exported configuration holds only a reference.

> **DDEV:** save the value without committing it —
> `ddev dotenv set .ddev/.env --discord-webhook-url=<value>` then `ddev restart`.
> Keep `.ddev/.env` out of version control.

## A note on egress

Every notification is **sent out to a third party**. The message text — which can
include content titles, usernames, and event details — leaves your site and lands
in Discord. Choose which notification types to enable with that in mind, and
double‑check who can read the target Discord channel.
