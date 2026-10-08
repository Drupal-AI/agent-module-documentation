# Macy.js — manual setup guide

**Macy.js** (`macyjs`) adds a **Views style plugin** that lays out your view's
rows as a responsive, **Masonry‑style multi‑column grid** — the Pinterest‑like
layout where items of different heights pack neatly into columns without gaps. It
does this using the lightweight
[Macy.js](https://github.com/bigbite/macy.js) JavaScript library, so the grid
reflows fluidly as the viewport changes.

It is a pure display feature. Once enabled, you pick **Macy.js** as a view
display's **Format** and configure the grid — how many columns, the spacing
between items, and how the column count changes at different screen widths. It is
ideal for image galleries, portfolios, card or teaser listings, product grids,
and team pages.

Because it is only a Views display plugin, Macy.js adds **no routes, permissions,
or configuration entities** of its own — every setting is a numeric or boolean
option entered by someone who already has Views admin access. It requires the
core **Views** module.

> **One deployment note.** The Macy.js library is loaded from the jsDelivr **CDN**
> (`https://cdn.jsdelivr.net/npm/macy@2`, version 2.5.1). If your site has a strict
> Content Security Policy or must work offline, self‑host the library asset and
> point the module's library definition at your local copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Views is required).

There is **no separate settings form** — all configuration lives on the view
display's format settings, described in "How to use it" below.

## Where it lives in the admin menu

Macy.js adds no admin page. You use it entirely from the **Views UI** (**Structure
→ Views**), by choosing **Macy.js** as a display's **Format**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a **View**, and in the display's **Format** setting choose
   **Macy.js**.
3. Open the format's **Settings** and configure the grid:
   - **Number of columns** for the grid.
   - **Horizontal (X)** and **vertical (Y) margins** between items.
   - **Responsive breakpoints** via the `breakAt` field — for example
     `1200: 4, 640: 2` to use four columns above 1200px and two below 640px.
   - **`mobileFirst`** — how the breakpoints are interpreted (mobile‑first or
     desktop‑first).
   - **`waitForImages`** — let the layout settle after images have loaded, which
     avoids overlap in image‑heavy grids.
   - **`useOwnImageLoader`** — use Macy's own image loader.
   - **`trueOrder`** — preserve the source order of items across columns.
4. Save the view. Each view display gets its own container, so you can reuse the
   plugin across several views, each with independent settings. Style the items
   using the row plugin's row classes as usual.
