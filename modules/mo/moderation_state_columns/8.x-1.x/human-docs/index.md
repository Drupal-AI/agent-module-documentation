# Moderation state columns — manual setup guide

**Moderation state columns** (`moderation_state_columns`) is a Views **style
plugin** that arranges moderated content into columns — one column per workflow
state — giving editorial teams a Kanban-style board of their content. At a glance
you can see what is Draft, what is Published, what is Archived, and how items move
through your editorial pipeline.

It builds directly on core **Content Moderation** and **Views**. You create a
View of moderated entities the normal way, then set its display format to
**Moderation state columns**. In the format settings you choose a **workflow**
and pick which of its **states** should become columns. When the View renders,
the module buckets each result row under its entity's current moderation state
and a small bundled JavaScript library draws the columns from that data.

Because it is a Views style, there is nothing to configure globally — no settings
page, no permissions, no routes. Who can see a board is governed entirely by the
View's own access settings and by each entity's access; the plugin only lays out
rows that Views has already resolved. Cache tags from the workflow and each entity
are merged in so the board invalidates correctly. This guide folds the setup
steps into this page rather than a separate configuration chapter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Content Moderation and Views.

There is **no configuration page** for this module. You set it up on a View's
display, as described in "How to use it" below.

## Where it lives in the admin menu

Moderation state columns adds no admin settings page of its own. You use it from
the Views UI at **Structure → Views** (`/admin/structure/views`), where you set a
display's **Format** to **Moderation state columns**.

## How to use it

1. Make sure your site uses core **Content Moderation** with at least one
   workflow applied to the entities you want to board (for example Content).
2. Create a View that lists those moderated entities, using either the **fields**
   or **entity** row style (this style renders each row through a row plugin).
3. In the View, set the display **Format** to **Moderation state columns**.
4. Open the format **Settings** and:
   - Choose a **Workflow** (required). Changing it reloads the list of available
     states via AJAX.
   - Select one or more **States** to show as columns.
5. As the settings help notes, still add the moderation-state **filter and/or
   fields** to the View itself — the style only decides which state columns to
   render; it does not filter the result set for you. Add other Views filters
   (author, content type, date) to scope the board.
6. Save the View. Visiting it now shows your content laid out as a board, one
   column per selected state.

> **Tip:** On sites with more than one workflow, build a separate board View per
> workflow — each board is bound to a single workflow.
