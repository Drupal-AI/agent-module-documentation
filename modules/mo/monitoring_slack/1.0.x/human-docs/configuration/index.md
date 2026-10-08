# Configuration

All of Monitoring Slack's settings live in the **Slack notifications** section of
the Monitoring settings form — there is no separate page.

## Create a Slack incoming webhook

First, create an incoming webhook in Slack at
[api.slack.com/messaging/webhooks](https://api.slack.com/messaging/webhooks) and
copy its URL. It will look like
`https://hooks.slack.com/services/T.../B.../...`.

## Open the settings

1. Log in as a user with the **Administer monitoring** permission.
2. Go to **Configuration → System → Monitoring settings**
   (`/admin/config/system/monitoring`).
3. Scroll to the **Slack notifications** section.

## Fill in the fields

- **Webhook URL** *(required to send)* — paste the incoming webhook URL you
  created. This is what connects the module to your Slack channel.
- **Severities** — tick the status changes worth notifying about (OK, INFO,
  WARNING, CRITICAL, UNKNOWN). A notification fires only when a sensor's new
  status is one you have ticked and differs from its previous status.
- **Channel / bot display name / icon emoji** *(optional)* — overrides for where
  the message posts and how the bot appears. These are honoured **only by legacy
  incoming webhooks**. Webhooks created through a modern Slack App always post as
  the app to the channel configured in Slack, and ignore these fields — so leave
  them empty in that case and set the display name and icon in Slack instead.

## A note on the webhook URL as a secret

The webhook URL is a secret-bearing value: anyone who has it can post into your
channel. This module stores it in **plain configuration**
(`monitoring_slack.settings`), so be mindful when you export configuration — the
URL will be included. Keep exported config out of public repositories, and rotate
the webhook in Slack if it may have leaked. Posting happens over HTTPS with normal
TLS verification.

## Send a test

Use the **Send test notification** button on the form to post an ad-hoc message
using the current (unsaved) values — a quick way to confirm the webhook works
before you save.

## Make sure call logging is on

Notifications depend on Monitoring detecting a *transition* between runs. If
**Monitoring settings → Log calls** is set to *none*, transitions cannot be
detected and nothing is sent. Leave call logging enabled.

## Save

Click **Save configuration**. From then on, qualifying sensor status changes will
be posted to your Slack channel, colour-coded by severity, with a link back to the
sensor details.
