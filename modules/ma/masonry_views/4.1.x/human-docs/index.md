# Masonry Views — manual setup guide

**Masonry Views** (`masonry_views`) adds a **Masonry** format to Views, so you can
render a view's results as a cascading, gap‑filling grid — the "Pinterest" look,
where items of varying heights pack neatly together without leaving big gaps. It is
perfect for portfolios, galleries, blog walls, product cards, and team listings.

The module itself is small and focused: it provides a single Views **style plugin**
that you select as a display's Format. The actual layout work is done by the separate
**Masonry** module, which wraps the jQuery Masonry library. Masonry Views wires that
library's options into the Views UI and renders the right markup — a `.masonry-item`
wrapper around each result inside a predictable `.masonry-layout-<view-id>` container
— then hands off to the Masonry module to lay everything out.

Because it uses a row plugin, you can build the grid from rendered entities (teaser
cards) or from fields, add per‑row CSS classes for custom card styling, and even use
Views grouping while keeping the masonry packing within each group. All the layout
knobs — column width, gutter (gap) size, resizable and animated behavior,
images‑loaded handling, lazy‑load selectors, RTL, stamps, and so on — come from the
Masonry module and appear as a "Masonry" fieldset in the format settings.

There is no admin settings page and no permissions — everything is configured per
view. If the jQuery Masonry library is not installed, the options are disabled and no
layout is applied, so make sure the Masonry module and its library are in place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Masonry module) and enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You use Masonry Views from within the **Views
UI** at **Structure → Views** (`/admin/structure/views`), by choosing **Masonry** as
a display's Format.

## How to use it

1. Edit the view you want to restyle (**Structure → Views → your view**).
2. In the display, click the **Format** setting and choose **Masonry**, then open its
   **Settings**.
3. In the **Masonry** fieldset, set the layout options — for example the **gutter
   width** (gap between items), whether the layout is **resizable** and **animated**,
   and whether to wait for **images to load** before packing.
4. Pick a **Row style** as usual (rendered entity or fields), and **Save**.

The view now renders as a masonry grid. Style the container with the
`.masonry-layout-<view-id>` selector and individual cells with `.masonry-item` — for
example to add hover overlays.
