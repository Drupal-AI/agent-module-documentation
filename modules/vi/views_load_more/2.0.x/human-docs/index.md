# Views Load More — manual setup guide

**Views Load More** (`views_load_more`) adds a **"Load more" pager** to Views.
Instead of numbered page links at the bottom of a list, the view shows a button
that fetches the next page of results over AJAX and **appends** them to the
bottom of the existing list — so readers keep scrolling a growing list rather
than jumping between numbered pages. It's the classic pattern for blogs, news
feeds, product grids, activity streams, and search results.

Under the hood it's a single Views **pager plugin** that extends core's Full
pager, so it inherits familiar options like items‑per‑page and offset, and simply
replaces the page‑number links with a themed button. When AJAX is enabled on the
display, the module intercepts the normal Views "replace" behaviour and swaps in
an "append" behaviour instead (with an optional fade‑in or slide‑down effect), so
the already‑loaded results stay on screen — no full‑view reload and no visible
flash. If AJAX is off, the button gracefully degrades to a plain next‑page link,
so it still works without JavaScript.

There is **no admin settings page** — you configure everything per view display,
right in the Views UI, where you pick the pager. You can set the button label, an
optional "finished" message shown when the last page is reached, an animation
effect, and (for themes with custom markup) advanced CSS selectors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Load More has no configuration page of its own. You select and configure it
inside any View, in that display's **Pager** section (**Structure → Views**, edit
a view).

## How to use it

### Turn a view's pager into "Load more"

1. Edit the view and, on the display, click the current **Pager** setting
   (usually "Mini" or "Full").
2. Choose **Load more pager** ("Paged output, each page loaded via AJAX") and
   click **Apply**.
3. In the pager options, set **Items to display** (and an optional **Offset**),
   plus the text options below.
4. **Enable AJAX** on the display: under **Advanced → Use AJAX**, set it to
   **Yes**. This is what makes new pages *append* instead of reloading the whole
   view. (Without AJAX the button still works, but as an ordinary next‑page
   link.)
5. **Save** the view.

### The pager options

- **Load more text** — the label on the button (default "Load more"). Customise
  it per display, e.g. "Show me more" or "View older comments".
- **Finished text** — an optional message shown in place of the button once the
  last page is reached, e.g. "No more results". Leave empty for no message.
- **Effect type / speed** — an optional jQuery animation for the appended rows:
  **None**, **Fade in**, or **Slide down**, at **slow** or **fast** speed. Gives
  a smoother reveal.
- **Content selector** and **Pager selector** (advanced) — CSS selectors the
  JavaScript uses to find the rows container and the pager. You only need to
  change these if your theme overrides the default Views row or pager markup;
  otherwise the defaults work.

Both text options are translatable through the standard interface translation,
and the whole pager configuration exports with the view for deployment across
environments.

### Tips

- **Infinite scroll:** pair Views Load More with the
  [Waypoints](https://www.drupal.org/project/waypoints) library so the next page
  loads automatically when the button scrolls into view, instead of on click.
- It handles **table** and **list** (ul/ol) styles correctly, placing appended
  rows in the right container — so it works beyond the default unformatted list.
