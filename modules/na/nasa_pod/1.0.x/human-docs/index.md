# NASA Pic of the Day — manual setup guide

**NASA Pic of the Day** (`nasa_pod`) displays NASA's **Astronomy Picture of the
Day** (APOD) on your Drupal site. It fetches the daily entry from NASA's public
APOD API and renders it — the image (or video), its date, media type, and NASA's
explanatory text — both on a dedicated page and as a placeable block. It is a nice
way to add a daily‑changing hero or feature to an education, outreach, or
astronomy‑themed site.

Under the hood it uses a small Guzzle‑based HTTP client to call
`https://api.nasa.gov/planetary/apod`, and it renders the result through Twig
templates with an attached styling library. It works the moment you enable it —
there is no settings form to fill in and no API key you must obtain, because the
module uses a built-in default NASA API key (see the note below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Setup is just enabling it and then linking to the page or placing the block.

## How to use it

Once the module is enabled:

- **Dedicated page:** visit or link to **`/nasa/pic-of-the-day`**. This route
  renders the full detail view and is available to anyone with the core **View
  published content** (`access content`) permission.
- **Block:** go to **Structure → Block layout** (`/admin/structure/block`), click
  **Place block** in your chosen region, and select the **NASA Pic of the Day**
  block to show the daily picture anywhere on the site.

Both the page and the block handle image *and* video APOD entries automatically.
If you want to change the look, the output comes from the
`nasa-pod-detail.html.twig` and `nasa-pod-block.html.twig` templates, which you
can override in your theme.

## A note on the NASA API key

There is no field for a NASA API key because the module uses a built-in default
key. That means the module works out of the box, but every site using it shares
that key's request quota. If you
run a busy site and want your own rate limit, obtain a free key from
[api.nasa.gov](https://api.nasa.gov/) — supplying your own key requires a code
change, since there is no admin form for it in this version. Consider caching the
daily result so repeat visitors do not each trigger a fresh API call.
