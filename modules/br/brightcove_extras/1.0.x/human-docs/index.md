# Brightcove Extras — manual setup guide

**Brightcove Extras** (`brightcove_extras`) is an umbrella of complementary
utilities that build on top of the contributed **Brightcove** video module. The
base module itself is small — it ships a shared `BrightcoveEmbedUrl` helper and
carries no hard runtime dependency of its own. The useful features come from four
focused submodules, and you enable only the ones you need.

The four submodules are:

- **Brightcove Extras Player** (`brightcove_extras_player`) — renders a Brightcove
  embed URL as a responsive, in‑page [video.js](https://videojs.com/) player
  instead of an iframe, via a field formatter and a themeable component.
- **Brightcove Extras GA4** (`brightcove_extras_ga4`) — pushes Google Analytics 4
  video‑engagement events (`video_start`, `video_progress`, `video_complete`) to
  the browser dataLayer for those players.
- **Brightcove Extras Admin** (`brightcove_extras_admin`) — adds an editor‑facing
  overview View of your Brightcove videos (searchable by title/ID) plus a
  broken‑reference report that finds content pointing at deleted videos (backed by
  the Entity Usage module).
- **Brightcove Extras Sync** (`brightcove_extras_sync`) — syncs only the videos
  changed since the last run (an incremental sync) instead of a full nightly
  reconcile, and adds Drush commands to run it.

Use it to improve on the stock Brightcove integration with a native player,
analytics, admin tooling, and faster incremental syncing — picking and choosing
per site.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling just the submodules you want.

## Where it lives in the admin menu

The base module adds no admin pages of its own. Each submodule that has settings
exposes them under its own configuration object (for example
`brightcove_extras_ga4.settings`, `brightcove_extras_admin.settings`, and
`brightcove_extras_sync.settings`); those settings and reports are permission‑gated
admin routes. The player submodule adds a **field formatter** you choose under
**Structure → Content types → Manage display**, and the admin submodule adds a
Brightcove videos **View** you reach from the admin content area.

## How to use it

1. Make sure the contributed Brightcove module is installed and configured (the
   submodules that talk to Brightcove depend on it).
2. Install Brightcove Extras and enable only the submodules you need (see
   [Installation](installation/index.md)).
3. For the player, set the **in‑page player** formatter on your Brightcove video
   field under Manage display. For analytics, configure the GA4 submodule. For
   admin tooling, open the Brightcove videos View and the broken‑reference report.
   For faster syncs, enable the sync submodule and run its Drush command.
