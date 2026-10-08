# Views AJAX History — manual setup guide

**Views AJAX History** (`views_ajax_history`) makes AJAX‑enabled Views play nicely
with the browser's back/forward buttons and with bookmarking. By default, when a View
uses AJAX, changing an exposed filter or clicking a pager updates the results in place
but never touches the browser's URL — so the back button leaves the page entirely, and
the current filter/page state can't be bookmarked or shared. This module fixes that.

It works by pushing each new filter or pager state into the browser's history (using
the HTML5 History API's `pushState`) with a cleaned‑up URL, and by re‑issuing the
Views AJAX request when the visitor navigates back or forward. The result: the URL
always reflects what's on screen, the back button walks through previous
filtered/paged states instead of abandoning the page, and any state can be bookmarked
or shared as a deep link.

There's no admin settings page and no PHP to write — you turn the feature on **per
view** with a single checkbox, and optionally list a few query arguments to strip from
the pushed URL. It depends only on core's **Views** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central configuration form. The feature is switched on inside the **Views
UI** (`/admin/structure/views`), on each individual view where you want it.

## How to use it

1. Make sure the view already uses AJAX: in the Views UI, open **Advanced → Use AJAX**
   and set it to **Yes**. Views AJAX History only does anything on AJAX views.
2. In that same **Use AJAX** settings dialog, tick the **AJAX history** checkbox that
   this module adds. (Technically it's a Views *display extender*, which is why the
   option appears right next to the core AJAX toggle.)
3. Save the view. Now, as visitors apply exposed filters or click pager links, the URL
   updates and the back/forward buttons restore each state.

Optionally, the same settings offer an **"Exclude query arguments from the URL"**
textarea. List any query keys (matched by "starts with") that you want kept out of the
pushed history URL — handy for stripping tracking parameters or unrelated query
strings while the module rewrites only the views‑related ones.

That's the whole setup. The behavior is remembered as part of the view's
configuration, so it exports and deploys with the rest of your config.
