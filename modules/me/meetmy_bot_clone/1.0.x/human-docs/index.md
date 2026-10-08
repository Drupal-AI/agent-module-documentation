# MeetMy.bot Clone — manual setup guide

**MeetMy.bot Clone** (`meetmy_bot_clone`) embeds the **MeetMy.bot Clone**
conversational‑AI chatbot (by Eternity.ac) into a Drupal site using Drupal's block
system. Once you point it at your MeetMy.bot service URL, you can place an AI
chatbot widget anywhere blocks can go — for customer support, lead generation,
guiding shoppers, an educational assistant, or automating first‑contact
consultations. The bot appears in a clean modal overlay that does not disrupt your
site's design, and the interface is mobile‑first and built for WCAG 2.1 AA
accessibility with keyboard and screen‑reader support.

Rather than building chatbot functionality from scratch, you configure a service URL
once and drop in a block. Because it is block‑based, you can run **multiple bot
instances** across the site, each with its own settings — and each block can override
the global title, window dimensions and preview‑video preferences. An optional
**preview video** can introduce the bot before a visitor interacts with it, and the
module uses lazy loading to keep the page fast.

MeetMy.bot Clone depends only on core **Block** and **System**, works on Drupal 10
and 11, and needs a MeetMy.bot service URL (from Eternity.ac) to function. Setup is
two parts: enter the global settings, then place one or more bot blocks — both
covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the global bot options, then place
   and tune the bot block(s).

## Where it lives in the admin menu

- Global settings are at **Configuration → Web Services → MeetMy.bot Clone**
  (`/admin/config/services/meetmy-bot-clone`).
- You place bots from **Structure → Block Layout** (`/admin/structure/block`).

## How to use it

1. Set the **global configuration** (bot title, service URL, window size, optional
   preview video) on the settings page — see [Configuration](configuration/index.md).
2. Go to **Structure → Block Layout**, click **Place block** in the region you want,
   and add the **MeetMy.bot Clone** block.
3. Optionally override the global title/dimensions/preview for that specific block,
   and set the usual block **visibility** conditions (pages, roles, etc.).
4. Visit a page where the block is placed to see the bot in action. Repeat to create
   different bots (support, sales, and so on) in different places.
