# Views Block Area — manual setup guide

**Views Block Area** (`views_block_area`) lets you drop any block into a View —
without going through the site's Block Layout. It exposes every ordinary
(non‑context‑aware) block as two new Views handlers: an **area** handler you can add
to a view's header, footer, or "no results" area, and a **field** handler you can
add alongside your result rows.

This is handy when you want a promo or call‑to‑action block at the top of a
listing, a "powered by" or branding block in the footer, helpful content shown when
a view returns nothing, or a menu/search/social‑sharing block rendered next to each
row. Because the block lives inside the view's own configuration, it travels with
the view when you export it — you don't have to remember a separate Block Layout
placement.

For each block you add you can override its title, hide its label, and (for the
area handler) choose whether it still renders when the view has no results. The
module respects block access, so a visitor only sees a block they're allowed to
see. Context‑aware blocks are deliberately left off the list, since a view can't
supply the runtime context they need.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Block Area has **no settings page of its own**. Everything is configured
inside the **Views UI** (**Structure → Views**, then edit a view). Its choices are
stored in the view's own configuration.

## How to use it

### Add a block to a view's header, footer, or "no results" area

1. Edit the view under **Structure → Views**.
2. Next to **Header**, **Footer**, or **No results behavior**, click **Add**.
3. Choose **Global: Block area**.
4. In the settings, pick the **Block** you want to render, then optionally:
   - set a **title override**,
   - tick **hide label**,
   - tick the "render even when the view has no results" option (this is what makes
     a block useful in the *No results behavior* area).
5. Apply and save the view.

### Add a block as a field in each row

1. Edit the view and click **Add** next to **Fields**.
2. Choose **Content block: Block field**.
3. Pick the block and set the title/label options as above.
4. Apply and save.

The block now renders in your chosen spot for anyone who has access to it.
