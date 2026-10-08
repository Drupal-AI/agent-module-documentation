# Mattermost Logger — manual setup guide

**Mattermost Logger** (`mattermost_logger`) forwards Drupal's log messages to a
**Mattermost** channel using Mattermost **incoming webhooks**. If your team lives in
Mattermost, this lets Drupal alerts — errors, warnings, security events — land
directly in a channel instead of sitting unnoticed in the database log.

It hooks into Drupal's logger service and lets you decide, per logging channel,
which messages get sent and at what severity. You can point each Drupal logging
channel at its own webhook, or fall back to a single default webhook, and messages
arrive in Mattermost with color‑coded indicators by severity. Developers can also
call the `mattermost_logger` service directly to post a message from custom code.

Two things are worth thinking about before you turn it on. First, the **webhook URL
is a secret** — anyone who has it can post into your channel — so keep it out of
plain configuration that lands in git. Second, **log messages can contain sensitive
data**: modules sometimes log tokens, credentials, or personal data, and forwarding
logs to a chat channel forwards whatever those messages contain. Send only the
severities and channels you actually need, and treat the destination Mattermost
channel as a place that now holds potentially sensitive log content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add logging channels, their webhooks,
   and the severities to forward.

## Where it lives in the admin menu

Once enabled, its settings form lives at **Configuration → Web services → Mattermost
Logger** (`/admin/config/services/mattermost-logger/settings`).

## How to use it

After you configure at least one channel and webhook, the module logs matching
messages to Mattermost automatically. To post from your own code:

```php
\Drupal::service('mattermost_logger')->error('my_module', 'My error message');
```
