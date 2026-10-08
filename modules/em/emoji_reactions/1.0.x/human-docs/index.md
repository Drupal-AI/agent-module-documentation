# Emoji Reactions — manual setup guide

**Emoji Reactions** (`emoji_reactions`) adds a full‑featured, per‑entity emoji
reaction system to a Drupal 10 or 11 site. Drop its field onto any fieldable
entity — nodes, comments, taxonomy terms, users, paragraphs, and more — and
visitors and editors can react with a single click. Reactions are stored, counted,
and updated live via AJAX without a page reload, and you can render them with any
of 23 ready‑made display layouts, from simple pills and cards to styles modelled on
Facebook, Reddit, Slack, and Discord.

It's built to be more than a "like" button. Six emojis are installed and ready
(👍 ❤️ 🎉 😢 😮 😡), and you can add your own — as Unicode characters, image URLs,
or raw SVG — reorder them by drag‑and‑drop, and enable or disable them globally.
You can allow one reaction per user per item or several at once, let users swap
their reaction, and even permit anonymous reactions (tracked by IP, session, or
both, with an expiry window). Flood protection, real‑time count polling, click
animations, tooltips, and accessibility labels are all built in. For measurement,
every reaction is written to a filterable **reaction log**, and per‑entity and
site‑wide **statistics** reports summarise engagement. A REST API and Views
integration round it out for decoupled or custom builds.

The module depends on core's **User**, **Field**, and **REST** modules (and
Serialization, which REST requires) and provides its own permissions. Because
reactions are user‑submitted and the analytics tie users to content — personal
data — gate the reaction and log permissions appropriately, make sure the REST
endpoints enforce access, and expose the logs and statistics only to appropriate
roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — attach the reaction field, choose a
   layout, manage emojis, set permissions and anti‑abuse options, and find the log
   and statistics.

## Where it lives in the admin menu

Emoji Reactions is set up in a few places:

- **Manage fields** on any content type (or other entity bundle) — to attach the
  `emoji_reaction` field.
- **Manage display** on that bundle — to pick one of the 23 layouts per view mode.
- The module's **emoji management** admin list — to add, order, enable, or disable
  emojis and set behaviour options.
- **Reports → Emoji Reactions Statistics** — for the site‑wide analytics, plus the
  filterable reaction log.
