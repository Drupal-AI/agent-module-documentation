# Discord — manual setup guide

**Discord** (`discord`) is a one‑way bridge from your Drupal site into a Discord
channel. When something happens on the site — a deploy finishes, content is
published, a contact form comes in — the module can post a message about it to a
channel you nominate, using Discord's own **incoming webhook** feature. It sends
both plain‑text messages and richer "embed" cards (with a title, description,
colour, author, and link).

The problem it solves is keeping a team channel informed without anyone having to
log into the Drupal admin. Instead of emailing yourselves or checking the site,
you get the update where your team already is. Traffic only ever flows *out* to
Discord — the module provides no inbound listener or bot, so there is no callback
endpoint on your site to worry about.

Discord needs a small amount of configuration before it does anything: you must
paste in the Discord webhook URL (and optionally a default bot username and avatar
image). Once that is set, you can send messages from other modules through its
`discord` service, or — if you also enable core/contrib **Rules** — wire up "send
a Discord message" as an action that fires on events like node publish or user
registration. The module has no hard dependencies beyond Drupal core; Rules is
optional.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) enable Rules.
2. [Configuration](configuration/index.md) — set the webhook URL, default bot
   name and avatar, and send a test message.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Discord**
(`/admin/config/services/discord/config`, route `discord.admin_settings`). It is
gated by the **Administer site configuration** permission. Two built‑in test
forms — `/admin/config/services/discord/test_message` and `…/test_embed` — let you
fire a message at your channel to confirm everything is wired up.
