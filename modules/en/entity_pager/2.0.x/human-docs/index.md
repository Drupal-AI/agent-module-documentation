# Entity Pager — manual setup guide

**Entity Pager** (`entity_pager`) adds **Next / Previous / All** navigation to an
entity's page. On a node (or user, taxonomy term, media item, and so on) you can
show a `< prev · All · next >` pager that walks visitors through a defined sequence
of sibling entities — the next article in a blog, the next product in a brand, the
next record in a set. It's the friendly way to give content "previous story / next
story" links without writing a custom module.

The whole module is a single Views **style plugin**, so you drive the sequence with
an ordinary View. You build a View (usually a **block** display) that lists the
entities you want to page through — for example all published Articles, ordered by
date — and set its **Format** to *Entity Pager*. When that block is shown on an
entity's page, the module detects the current entity from the URL, finds its row in
the View's results, and renders links to the entities immediately before and after
it. Because you control the View's filters and sorts, you control exactly which
entities are in the sequence and in what order.

The style's settings (on the View, not on any admin page) let you customise the
prev/next/All labels (HTML allowed, so you can use arrow icons), set the "All" link's
URL and text (both accept tokens like `[node:field_company]`), show a position
counter ("5 of 8"), enable circular paging (so the last item's "next" wraps to the
first), and choose whether to show greyed‑out disabled links at the ends. An optional
Views **relationship** lets the pager navigate a *related* entity instead of the base
row. The module ships a disabled demo View, `entity_pager_example`, with a ready‑made
block you can enable to see it working.

There is no admin settings page, no permissions, and no Drush — the only dependency
is core **Views**, and all configuration lives inside your View.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There's no dedicated settings page. You configure Entity Pager inside the Views UI
(**Structure → Views**, `/admin/structure/views`) and place its block through
**Structure → Block layout**.

## How to use it

1. Create a View (**Structure → Views → Add view**) based on the entity type you
   want to page through (for example **Content**), with a **Block** display.
2. Add the entity's **ID** field (for nodes, *Content: nid*) so each row resolves to
   an entity.
3. Set **Items per page** to `0` (all) and turn the **pager off** — Entity Pager
   needs the complete list to find neighbours.
4. In **Format**, choose **Entity Pager**, then click **Settings** to set the
   prev/next/All labels, the "All" link, the position counter, circular paging, and
   so on.
5. Add **filters and sorts** to define which entities are in the sequence and their
   order.
6. Place the resulting **block** on the entity's page via **Block layout**. On any
   entity whose ID appears in the View's results, the `< prev · All · next >` pager
   shows up.

Want a shortcut? Enable the shipped `entity_pager_example` View (it's off by
default) and place its example block for a working node pager to learn from.
