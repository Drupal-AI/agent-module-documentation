# FitVids — manual setup guide

**FitVids** (`fitvids`) makes embedded videos — YouTube, Vimeo, and other iframe
players — scale fluidly to the width of their container while keeping their
aspect ratio. It integrates the well‑known **FitVids.js** jQuery plugin: the
module attaches the library on every page and FitVids.js then wraps matching
video iframes in a fluid‑width container, so a video that used to have fixed pixel
dimensions resizes responsively on phones, tablets, and desktops.

FitVids works globally on the rendered page rather than as a field formatter or
block. You tell it which container selectors hold the videos it should make
fluid, optionally register extra video provider domains, and optionally list
selectors whose videos should be left alone. All of this lives in one small
settings form.

One setup note: FitVids expects the FitVids.js library file to be present at
`/libraries/fitvids/jquery.fitvids.js` — see [Installation](installation/index.md).

This guide is written for a **human** using the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the FitVids.js library file, and enable the module.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Media → FitVids**
(`/admin/config/media/fitvids`), gated by the **Administer FitVids** permission.

## How to use it

Open the settings form and adjust three fields (each takes one value per line):

- **Video containers** (`selectors`, default `.node`) — the CSS selectors of the
  containers whose videos should become fluid. Point this at wherever your videos
  live — the node body, a teaser wrapper, a specific region, or several
  selectors at once.
- **Additional video providers** (`custom_vendors`, default `https://youtu.be`) —
  extra iframe `src` prefixes to treat as videos, on top of the built‑in
  providers. For example, add `https://vimeo.com` to make Vimeo embeds fluid.
- **Ignore these videos** (`ignore_selectors`, empty by default) — selectors
  whose videos should be left untouched, so you can exclude a slider, carousel,
  or decorative background iframe.

Click **Save configuration**. The settings are stored in the `fitvids.settings`
config object and export/import like any other config. The **Administer FitVids**
permission controls who can change them.
