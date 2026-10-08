# Round Linking — manual setup guide

**Round Linking** (`round_linking`) helps you interlink your content in a
**closed circle**. The idea is that each item in a set links onward to the next,
and the last item loops back to the first — so a group of pages forms a ring where
every item both receives inbound links and points to others. It's a tidy way to
build "next in series", guided‑tour, or related‑content navigation.

Beyond the reader‑friendly navigation, circular internal linking is good for SEO:
well‑planned internal links help search engines discover, crawl, and understand
the structure of your site, and a ring guarantees every item in the set stays
connected to the others.

Round Linking works through **Views**. It provides a Views handler you add to a
View block, which produces the circular linking for the content in that View. It
builds on core's **Node** and **Field** modules and adds no standalone settings
page of its own — the setup happens inside the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** — you set it up inside Views, as
described below.

## How to use it

1. Go to **Structure → Views** (`/admin/structure/views`) and create (or edit) a
   View, adding a **block** display.
2. Add the **Round Linking** handler provided by this module to the View so the
   listed content is linked in a circular manner — each item referring to the
   next, and the last back to the first.
3. Save the View, then place the resulting **View block** in a region via
   **Structure → Block layout** where you want the interlinking to appear.
