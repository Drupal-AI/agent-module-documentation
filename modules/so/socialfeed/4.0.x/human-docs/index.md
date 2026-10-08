# Social Feed — manual setup guide

**Social Feed** (`socialfeed`) pulls recent posts from a **Facebook** Page, an
**X (Twitter)** account, and/or an **Instagram** professional account and shows
them on your site as themeable Drupal blocks. It is a straightforward way to add
social proof to a marketing site, keep a sidebar showing your latest posts, or
build a wall of brand content aggregated from several networks at once.

The module provides three block plugins — **Facebook Block**, **X (formerly
Twitter) Post Block**, and **Instagram Post Block**. Credentials and display
options (how many posts to show, whether to trim text, hashtag/mention linking,
timestamp format, and so on) are set centrally on three per‑platform settings
forms, and any single block can optionally override those globals with its own
credentials via a **Customize Feed** option.

Because it talks to real social‑platform APIs, Social Feed has real requirements:
**PHP 8.2 or newer** and three third‑party PHP libraries that Composer installs
for you (an X API v2 client, the Facebook Business SDK, and the Carbon date
library). Two important caveats: the **free X API tier cannot read posts** (you
need paid API credits), and Instagram requires a **Professional (Creator or
Business) account** on the Instagram Graph API. It has no submodules and works on
Drupal 10.3+ and Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the collector
services and the Instagram OAuth API — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries
   with Composer, and enable it.
2. [Configuration](configuration/index.md) — enter each platform's credentials
   and display options, complete Instagram OAuth, and place the blocks.

## Where it lives in the admin menu

The settings live at **Configuration → Web services → Social Feed**
(`/admin/config/services/socialfeed`), which links out to the Facebook, X, and
Instagram settings forms. Everything is gated by the **Administer socialfeed**
permission. The blocks themselves are placed under **Structure → Block layout**.

## How to use it

At a high level: install the module (with its libraries), enter your API
credentials on the relevant platform settings form, then place the matching
block(s) in a region under Block Layout. Keeping credentials in the global
settings means you can just place blocks with no per‑block configuration; use a
block's **Customize Feed** override only when you need a second block pointed at
different credentials. The [Configuration](configuration/index.md) page walks
through each platform.
