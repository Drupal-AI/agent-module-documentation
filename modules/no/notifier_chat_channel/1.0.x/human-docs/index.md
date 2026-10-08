# Notifier Chat Channel — manual setup guide

**Notifier Chat Channel** (`notifier_chat_channel`) adds the **Chatter channel**
to the [Notifier](https://www.drupal.org/project/notifier) integration, so
Drupal can deliver notifications to chat services through Symfony's Chatter
transports. On its own, Notifier is just the framework; this module is what lets
a notification actually land in a chat room or channel.

It supports a broad list of services — Amazon SNS, Bluesky, Chatwork, Discord,
Fake Chat (for testing), Firebase, Google Chat, LINE Bot, LINE Notify, LinkedIn,
Mastodon, Mattermost, Mercure, Microsoft Teams, Rocket Chat, Slack, Telegram,
Twitter, Zendesk, and Zulip. Of these, **Discord, Slack, and Mercure** are noted
by the maintainer as tested and known to work; the others rely on the
corresponding Symfony transport being present and configured.

This module **depends on Notifier** and requires Drupal **10.3 or newer**. Like
the base module, its important consideration is credential handling: each chat
transport is configured with a DSN that carries a webhook URL, bot token, or API
key for the service — those are **secrets** and must be stored as such, and the
connections should be made over secure (TLS) endpoints. Sending to a chat service
also means Drupal makes outbound requests to that service, so your environment's
egress rules need to allow it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Notifier.
2. [Configuration](configuration/index.md) — defining a chat transport and
   storing its credentials safely.
