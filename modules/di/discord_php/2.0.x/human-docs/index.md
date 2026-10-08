# DiscordPHP — manual setup guide

**DiscordPHP** (`discord_php`) wraps the popular
[`team-reflex/discord-php`](https://github.com/discord-php/DiscordPHP) gateway
library so that Drupal can run an actual Discord **bot** — not just fire one‑way
webhooks. It gives you a service that manages the bot client, a Drush command that
runs the bot's long‑lived websocket connection, and a Symfony event system that
lets your code react to things happening inside Discord (for example, a message
being posted in a channel).

The problem it solves is two‑way integration. A webhook can only push messages out
to Discord; a bot can *listen* — receive messages, react to them, reply, and post
new messages under its own identity. This module is the plumbing for building that
kind of interactive integration in Drupal, whether in custom code or, with the
optional **ECA** submodule, as no‑code automation.

This is fundamentally a **developer / builder tool**: it has no admin settings
form. The one setup step in the UI is pasting your Discord bot token into a **Key**
entity that the module ships. Everything else — running the bot, subscribing to
events, sending messages — happens through code, Drush, or ECA. It requires the
**Key** module, and the ECA submodule additionally requires **ECA**. The bot
connects over the library's own TLS websocket/HTTPS, so all Discord traffic is
outbound; the module exposes no inbound HTTP route on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including
[`agent/api/discord.md`](../agent/api/discord.md) for the service and event API.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, secure the bot token in a Key, and run the bot.

There is **no configuration page** for this module — it defines no settings form.
The only setup in the UI is storing the bot token in a Key entity, which is
covered in Installation. Everything else is done from code, Drush, or the ECA
submodule.

## How to use it

The typical shape of a DiscordPHP integration:

1. **Create a bot in Discord** and copy its token (see Installation).
2. **Store the token** in the shipped `discord_php_token` Key entity, switching the
   Key to an environment or file provider first (see Installation — the default is
   insecure).
3. **Run the bot loop** with `drush discord-php:run`. This opens the websocket and
   stays connected. Use `--timeout=<seconds>` to make it shut down after a period
   (handy for testing); the default runs indefinitely, so in production you would
   run it under a process manager.
4. **React to events** from your own module by subscribing to
   `MessageCreateEvent` (an inbound message arrived) or `ReadyEvent` (the bot
   connected). Get the shared client from the
   `discord_php.services.discord_php_manager` service to send or reply to messages.
5. **Or go no‑code:** enable the `discord_php_eca` submodule to gain an ECA event
   ("a Discord message was received") and a "Send message" ECA action, so you can
   build reply logic entirely through ECA models.

> **Least privilege:** the bot runs with whatever permissions its Discord role
> grants, and it requests the MESSAGE_CONTENT intent, meaning it can read the full
> text of messages. Give the bot only the Discord permissions it genuinely needs.
