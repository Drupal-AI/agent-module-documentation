# Views Show More Pager — manual setup guide

**Views Show More Pager** (`views_show_more`) replaces a view's numbered
pagination with a single **"Show more" button** that loads the next batch of
results when clicked — the familiar "load more" pattern used for feeds, news
listings, and product grids. In AJAX mode the new rows load without a full page
reload and are appended below the existing ones; you can also have each click
replace the current results instead.

It's a lighter-touch alternative to infinite scroll: the user stays in control and
explicitly asks for more. A nice touch is that the first page can show a different
number of items than each subsequent click — for example 12 items up front, then 6
per "Show more" — which is handy for perceived performance. The button hides
automatically once the last page is reached.

The module adds a single Views **pager plugin** called "Show more pager" that you
choose in a view's *Pager* section. Because it extends core's SQL pager you keep
familiar options like "items per page" (used as the per-click batch size) and gain
a first-page **initial** count, a customizable **button label**, a choice between
**Append** and **Replace**, optional **animation** (fade, scroll, or both, with
speed and scroll-offset settings), and **advanced selector** overrides for custom
markup. It works with unformatted lists, HTML lists, tables, and grids. Views Show
More Pager **requires only core Views**, has **no settings page, permissions, or
Drush commands**, and stores everything inside the view's display configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including every pager
option, the LIMIT/OFFSET logic, and the AJAX response handling — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Views Show More Pager has no page of its own. You use it inside the **Views UI**
(**Structure → Views**), by choosing it in a view's *Pager* section.

## How to use it

1. Edit a view at **Structure → Views** (`/admin/structure/views`). For the smoothest
   "load more" behavior, turn on **Use AJAX** in the view's advanced settings.
2. In the **Pager** section, click the current pager type and choose **Show more
   pager**. Apply it.
3. Click the pager **Settings** and configure:
   - **Items per page** — how many results load per "Show more" click.
   - **Initial** — how many items show on the first page. Leave it at `0` to use
     the same count as items-per-page, or set a larger number for a bigger first
     page.
   - **Show more text** — the button label (for example "Load more articles").
   - **Result display method** — **Append** to add the next batch beneath the
     existing rows (a growing feed), or **Replace** to swap in the next batch.
   - **Animation** (optional) — none, fade, scroll, or scroll+fade, with a speed
     (slow/fast/custom milliseconds) and a scroll offset.
   - **Advanced selectors** (optional) — override the content, pager, header, and
     footer jQuery selectors if your theme uses custom Views markup. The defaults
     (`.view-content` and `.pager-show-more`) work for standard markup.
4. Save the view.

In non-AJAX mode the pager still works by refreshing the page. You can theme the
button by overriding the `views-show-more-pager.html.twig` template — see the
[`agent/`](../agent/start.md) references.
