# Telega — manual setup guide

**Telega** (`telega`) is a developer‑oriented toolkit for building **Telegram**
integrations in Drupal — chiefly bots, but also the surrounding messaging pieces.
It gives you pluggable **bot** plugins plus Drupal entities for Telegram **users**,
**chats** and **messages**, so a custom module can connect Drupal to Telegram for
notifications, chat automation and other bot‑driven features. Under the hood it
builds on the well‑known `php-telegram-bot/core` library as the base API for
creating bots.

Out of the box it ships a couple of bot plugins to work from: a **Demo Bot** (based
on the php‑telegram‑bot example bot) and a **Generic Bot** — a blank, configurable
bot where you point it at a directory of your own commands. For the Generic Bot you
supply a small YAML configuration naming your module and a directory, and the bot
looks for command classes under `your_module/assets/DirectoryName/*`. This makes
Telega a foundation you extend rather than a turnkey feature. It provides its own
permissions and supports Drupal 9, 10 and 11.

Because this connects to Telegram, keep two security points in mind. First, the
integration authenticates with a **Telegram bot token** — that token *is* your bot:
anyone who holds it can control it, read what it can see, and post as it. Store it
as a secret (an environment variable, ideally behind a **Key** entity) and never
commit it to version control. Second, if you set up a **webhook** so Telegram can
push updates to your site, make sure inbound requests are actually coming from
Telegram before you act on them.

This guide is written for a **human** developer setting the module up. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Telega is a building block, so the work happens in your own module. After enabling
it:

1. **Create a bot with BotFather** in Telegram and obtain its **bot token**. Store
   that token securely (env variable / Key entity), never in code or config that
   gets committed.
2. **Start from a bundled bot.** Try the **Demo Bot** to see the moving parts, or
   use the **Generic Bot** as a blank slate.
3. **Point the Generic Bot at your commands.** Provide its YAML configuration —
   for example:

   ```yaml
   commands:
     my_module: DirectoryName
   ```

   The bot will then look for your command classes under
   `my_module/assets/DirectoryName/*`.
4. **Work with the entities.** Telega models Telegram users, chats and messages as
   entities, so your code can read and store them as part of your integration.

Review the module's permissions under **People → Permissions** and grant them to
the appropriate roles.
