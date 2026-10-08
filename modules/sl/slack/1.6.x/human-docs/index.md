# Slack — manual setup guide

**Slack** (`slack`) connects your Drupal site to a Slack workspace so the site
can post messages into a Slack channel. It works through an **Incoming
Webhook** — a special URL you generate inside Slack that lets an outside
application drop messages into a chosen channel. You paste that URL into
Drupal's settings once, set a few defaults (a channel, a bot name, an icon),
and from then on any message the site sends lands in Slack.

Messages can come from three places: your own custom code (using the module's
send service), the **Rules** module (so a site builder can wire up "when X
happens, post to Slack" without writing PHP), or a queue that delivers messages
in the background on cron instead of during the page request. A built-in test
form lets you fire off a message straight away to confirm everything is hooked
up before you automate anything.

The module has one important prerequisite: nothing is delivered until you have
saved a valid webhook URL. Because that URL is effectively a secret (anyone who
has it can post to your channel), treat it like a password — see the note in
[Configuration](configuration/index.md) about keeping it out of exported config
and version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field,
   getting a webhook URL from Slack, and the test message form.

## Where it lives in the admin menu

Once enabled, the module adds a **Slack** area under
**Configuration → Services**. Its settings form is at
**Configuration → Services → Slack → Configuration**
(`/admin/config/services/slack/config`) and the test form is at
`/admin/config/services/slack/test`. Both require the **Administer site
configuration** permission.

## How to use it

The everyday path is: get an Incoming Webhook URL from Slack, paste it into the
settings form along with a default channel and bot name, then send a test
message to confirm it works. After that, notifications can be triggered
automatically — from custom code via the `slack.slack_service` service (its
`deliverMessage()`, `sendMessage()` and `queueMessage()` methods), or from the
Rules module's **Send message to Slack** action. Each send can override the
channel, bot name or even the webhook per message, so you can route different
alerts to different channels. The code-level details are in the
[`agent/`](../agent/start.md) docs.
