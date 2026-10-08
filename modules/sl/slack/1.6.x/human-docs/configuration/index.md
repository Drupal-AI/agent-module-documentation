# Configuration

Everything the module sends is controlled from one settings form. Nothing is
delivered until you have saved a valid **webhook URL** here.

## First, get an Incoming Webhook URL from Slack

In your Slack workspace, create an **Incoming WebHooks** app or integration and
pick the channel it should post to by default. Slack gives you a URL that looks
like `https://hooks.slack.com/services/T00000/B00000/xxxxxxxx`. Copy it — that
is the value Drupal needs.

Treat this URL as a **secret**: anyone who has it can post into your channel. Do
not paste it into a settings file that gets committed to version control, and be
careful about exporting it in configuration that lands in a public repository.
The safest pattern is to keep the value in an environment variable and reference
it from your site rather than hard-coding it. With DDEV you can store it with
`ddev dotenv set .ddev/.env --slack-webhook-url=<value>` (keep `.ddev/.env` out
of version control) and read it back into the config object during deployment.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Services → Slack → Configuration**, or navigate
   directly to `/admin/config/services/slack/config`.

## The fields

- **Webhook URL** (`slack_webhook_url`) — the Incoming Webhook URL you copied
  from Slack. **Required**: with this empty, no message can be sent. This is the
  secret described above.
- **Channel** (`slack_channel`) — the default channel messages post to, written
  as `#channel-name` (for example `#general`). You can also use `@username` to
  send a direct message to a specific person. Individual messages can override
  this, so it is just the fallback.
- **Username** (`slack_username`) — the display name the bot posts under, for
  example `Drupal Bot`.
- **Icon type** (`slack_icon_type`) — choose how the bot's avatar is set:
  **none**, an **emoji**, or a **URL** to an image.
  - **Emoji** (`slack_icon_emoji`) — used when icon type is *emoji*; a Slack
    emoji code such as `:ghost:`.
  - **Icon URL** (`slack_icon_url`) — used when icon type is *url*; the address
    of an image to use as the avatar.
- **Link names** (`slack_link_names`) — when on, `@names` and `#channels`
  written inside a message are turned into real Slack links/mentions rather than
  plain text.
- **Queue messages** (`slack_queue_messages`) — when on, messages sent through
  the standard delivery path are placed on a queue and sent in the background on
  the next cron run, instead of during the page request. This smooths out bursts
  of notifications and avoids slowing down the request that triggered them. (It
  only affects the general `deliverMessage()` path; code can still force an
  immediate send or an explicit queue.)

Click **Save configuration** when done.

## Send a test message

Once saved, confirm the setup works before wiring up anything automated. Go to
`/admin/config/services/slack/test`, type a short message, and send it. If your
webhook, channel and bot settings are correct, the message appears in the Slack
channel within a few seconds. If it does not arrive, double-check that the
webhook URL was pasted in full and that the channel exists.

## Triggering messages automatically

With the settings saved, the site can post to Slack from custom code (via the
`slack.slack_service` service) or from the **Rules** module's *Send message to
Slack* action. Those developer-facing details — the service methods, per-message
overrides, and the background queue worker — are covered in the
[`agent/`](../agent/start.md) docs.
