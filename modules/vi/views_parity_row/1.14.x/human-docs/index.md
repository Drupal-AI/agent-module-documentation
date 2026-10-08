# Views Parity Row — manual setup guide

**Views Parity Row** (`views_parity_row`) gives Views a new **row plugin** that
renders most rows in one entity view mode but switches to a *second* ("alternate")
view mode on a repeating cadence — for example, every 3rd row — or on specific,
hand-picked row positions. It's the clean way to build a "featured + standard"
rhythm in a listing without writing a custom row template or preprocess code.

Think of a grid of teaser cards where every 5th card is a larger "featured"
layout, a magazine-style listing where the first row is a hero and the rest are
teasers, or a curated homepage block where each of the first several slots gets
its own view mode. Because the alternate look is simply a different view mode,
the two designs can be genuinely different displays (more fields, a bigger image,
a call-to-action), not just a CSS class difference.

The plugin is a variant of core's *Entity* row plugin and is generated
automatically for every entity type that Views can render — nodes, users,
taxonomy terms, media, Commerce products, and so on. It also keeps the cadence
counting correctly across paginated pages, so "every 3rd row" stays every 3rd row
when you move to page 2.

There is no admin settings page, no permission, and no Drush command — all the
options live inside the individual view's display, so this module is configured
entirely from within the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Parity Row has **no configuration page of its own**. You use it inside a
view at **Structure → Views** (`/admin/structure/views`), by choosing its row
plugin in that view's **Format** settings.

## How to use it on a view

1. Edit (or create) an entity-based view at **Structure → Views** — for example a
   view of Content (nodes). The view must render *entities*, not *Fields*.
2. In the view's **Format** section, click the **Show** setting and choose
   **"&lt;Entity type&gt; (alternate)"** — for a node view this is
   *"Content (alternate)"*. Apply it.
3. Click the **Settings** link next to Show to open the row options. You'll see:
   - **View mode** — the *primary* view mode used for normal rows (for example
     *Teaser*).
   - **Alternate every X rows** — tick this to turn on cadence alternation, then set:
     - **Frequency** — switch to the alternate mode every N rows (default 2).
     - **Start** — the first row (0-based) the cadence applies from (default 0).
     - **End** — stop applying at this row; **0 means no end** (apply all the way
       down the list).
     - **View mode** — the *alternate* view mode used on the cadence rows (for
       example *Full*).
   - **Alternate per row** — tick this instead (or as well) to hand-pick an exact
     view mode for each of the first 20 rows individually. A per-row choice
     overrides the cadence for that row.
4. Save the view. The listing now renders your alternating pattern — for example
   every 3rd row in the *Full* view mode and the rest as *Teaser*.

Because the alternate row is just another view mode, its appearance is entirely
whatever you've configured for that view mode under **Structure → Display modes**
and the entity's *Manage display*. The cadence rule is simple: with a start of 0,
the alternate mode fires on the 1st row and then every Nth row after it.
