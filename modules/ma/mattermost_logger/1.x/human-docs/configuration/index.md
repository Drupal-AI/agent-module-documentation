# Configuration

Configuration is where you connect Drupal's logging channels to Mattermost
webhooks and decide which messages get forwarded.

## Open the settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → Web services → Mattermost Logger**, or navigate directly
   to `/admin/config/services/mattermost-logger/settings`.

## Set up channels and webhooks

The form lets you map Drupal's logging system onto Mattermost:

- **Logging channels** — add the Drupal logging channels you want to forward (for
  example `php`, `cron`, or a custom module's channel). Only the channels you list
  are sent; everything else stays in Drupal's normal log.
- **Webhook per channel** — give each channel its own Mattermost **incoming
  webhook** URL, or leave it to fall back to a **default webhook** so several
  channels post into the same place.
- **Logging levels** — for each channel, select the severity levels to forward (for
  example only *Error* and *Critical*). This is your main control for keeping noise
  — and sensitive content — out of the channel.

Messages are displayed in Mattermost with **color‑coded indicators** so severity is
visible at a glance.

## Keep the webhook URL secret

A Mattermost incoming‑webhook URL is effectively a **write credential** for that
channel: anyone who has it can post to it. Don't paste it into configuration that
gets exported and committed to git in the clear. Where your workflow allows, supply
it from an environment variable or a secrets mechanism rather than hard‑coding it.
With DDEV you can store the value with
`ddev dotenv set .ddev/.env --mattermost-webhook=<url>` (keep `.ddev/.env` out of
version control) and `ddev restart`.

## Be deliberate about what you forward

Log messages can carry sensitive data — credentials, tokens, or personal
information that other modules may have written into a log entry. Forwarding logs to
a chat channel forwards that content too, and the destination channel then holds it.
Send only the severities and channels you genuinely need to see, restrict who can
read the Mattermost channel, and review your selection periodically.

## Save

Save the form. Matching log messages are forwarded to Mattermost from that point on.
