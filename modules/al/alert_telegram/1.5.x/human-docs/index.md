# Alert Telegram — manual setup guide

**Alert Telegram** (`alert_telegram`) sends alert and notification messages from
your site to Telegram. It pushes site events to a Telegram chat or channel
through a Telegram bot, so operators get quick notifications where they already
watch — useful for outage alerts and other operational messages.

It is an integration/notifications feature. It depends on core's Block module and
provides its own permission to control who can administer it. The important part
is how it authenticates: it talks to Telegram using a **bot token**, which is a
secret. Treat it like a password — see [Configuration](configuration/index.md)
for how to store it safely.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the bot token (as a secret) and
   the target chat, and grant the permission.

## Where it lives in the admin menu

Alert Telegram adds a settings form where you enter the bot token and the target
chat, and a permission on the **People → Permissions** page that governs who may
administer it. See [Configuration](configuration/index.md) for the details,
including safe handling of the bot token.
