# Recently Read — manual setup guide

**Recently Read** (`recently_read`) keeps a per‑user history of the content each
visitor has viewed, and lets you show it back to them as a "recently viewed"
list. Think of the *Recently viewed products* block on a store, or a *Recently
read articles* list for each logged‑in reader.

Tracking happens automatically. Whenever an entity of an enabled type is rendered
in its **full** view mode, the module records (or refreshes) a row in its
history. History is kept **per authenticated user**, and **per session** for
anonymous visitors — so a logged‑out shopper still gets a personalized "you
looked at these" list without having to sign in.

You control two things: **which entity types (and optionally which bundles) are
tracked**, and **how long the history is kept** — forever, pruned by age on
cron, or capped to the newest N records per user. Out of the box the module
tracks `node` content and ships a ready‑made view, `recently_read_content`, that
lists the current user's recently read nodes. You surface a history list by
placing that view's block, or by building your own view with the module's
"Recently read" Views relationship.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the `recently_read`
service API, the entities, and the Views plugins — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which entity types are
   tracked, set the pruning strategy, and display the history with Views.

## Where it lives in the admin menu

There are two admin surfaces:

- **Structure → Recently read types** (`/admin/structure/recently-read`) — the
  list of tracked entity types. This is the module's main "Configure" link.
- **Configuration → System → Recently Read** (`/admin/config/system/recently-read/config`)
  — the pruning / retention settings.

## How to use it

1. Install and enable the module.
2. On the *Recently read types* page, enable the entity types you want tracked
   (node is enabled by default) and optionally limit them to certain bundles.
3. Decide how history is pruned on the settings form.
4. Show the history by placing the shipped `recently_read_content` view's block,
   or by building your own view with the "Recently read" relationship. From then
   on, browsing the site populates each user's list automatically.
