# Piano Analytics Short URL — manual setup guide

**Piano Analytics Short URL** (`pianoanalytics_shorturl`) is a small **bridge**
between two other modules: the
[Short URL](https://www.drupal.org/project/shorturl) module and the **Piano
Analytics Server** submodule of
[Piano Analytics](https://www.drupal.org/project/pianoanalytics). When a visitor
follows a short link and Drupal redirects them, this module sends a **server‑side
Piano Analytics event** recording that visit — so short‑link traffic shows up in
your Piano Analytics reports even when a visitor's browser blocks client‑side
tracking scripts.

It works entirely in the background: it listens for the Short URL module's visit
event and queues a Piano event through the server submodule, which then sends it
after the response (during `kernel.terminate`), so there is **zero added latency**
on the redirect itself. Each event is enriched with the short URL's slug,
destination URL, referrer, language, and domain (when Domain Short URL is
installed). It respects the Piano Analytics **opt‑out** consent cookie, so a
visitor who has opted out is not tracked.

This module has **no routes or permissions of its own** — it is purely a
connector. Its one small setting (the Piano event name) is folded into the Short
URL settings form, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Short URL / Piano Analytics dependencies.

There is **no dedicated configuration page** — its single setting lives inside the
Short URL settings form, covered under "How to use it" below.

## Where it lives in the admin menu

The module adds a **Piano Analytics** section to the existing **Short URL
settings** page at **Configuration → *(Short URL)*** — reachable at
`/admin/config/shorturl/settings`. That section only appears once this module is
enabled.

## How to use it

1. Make sure Piano Analytics is set up first — configure your Piano credentials in
   the **Piano Analytics Server** submodule (see the
   [Piano Analytics guide](../../../pianoanalytics/2.4.x/human-docs/configuration/index.md)).
   Short URL must also be installed and working.
2. Go to **Short URL settings** (`/admin/config/shorturl/settings`). The **Piano
   Analytics** section now appears.
3. Set the **PA event name** for short‑URL visits (defaults to `page.display`) and
   toggle tracking on or off. Save.

From then on, each short‑link redirect quietly queues a server‑side Piano event —
no further action needed. Because it honours the Piano opt‑out cookie, visitors
who declined tracking are automatically excluded.
