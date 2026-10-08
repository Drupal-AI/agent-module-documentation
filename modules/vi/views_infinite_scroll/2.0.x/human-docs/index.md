# Views Infinite Scroll — manual setup guide

**Views Infinite Scroll** (`views_infinite_scroll`) replaces the numbered page
links at the bottom of a View with a modern "endless feed" experience: either a
single **Load more** button, or automatic loading of the next page of results as
the visitor scrolls toward the bottom. Instead of clicking *Page 2, Page 3, …*,
the reader just keeps scrolling (or taps one button) and more rows appear in
place — ideal for blogs, image galleries, product listings, search results, and
social‑media‑style activity streams.

Under the hood the module adds a single Views **pager plugin** called *Infinite
Scroll*. You pick it in a View's pager settings — exactly where you would choose
"Full" or "Mini" pager — and a small piece of JavaScript fetches and appends the
next page over AJAX. Because it is only a pager, it works with any View display
(page, block, or an EVA entity‑embedded View) and any row style (grids, teasers,
unformatted lists, tables). Its only requirement is core's **Views** module, and
that the View itself has **AJAX enabled** — without AJAX the pager has no way to
fetch the next page, and the View edit form will warn you.

The module works as soon as you enable it, but it does nothing until you switch a
View's pager over to it — there is **no global settings page**. Everything is
configured per View, inside that View's *Pager* settings: the button label,
whether content loads automatically on scroll or only on a click, and whether all
previously‑paged rows load up front (handy when someone deep‑links straight to a
later page). The pager markup comes from a Twig template you can override in your
theme. There are no submodules and no third‑party libraries beyond Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Views Infinite Scroll has no configuration form of its own — you turn it on by
changing the pager on a specific View:

1. Go to **Structure → Views** (`/admin/structure/views`) and edit the View you
   want to scroll (or add a new one).
2. In the display, find the **Pager** row (it shows something like "Full" or
   "Mini"), click it, choose **Infinite Scroll**, and apply.
3. Open **Advanced → Use AJAX** and set it to **Yes**. This is required — the
   pager cannot append pages without AJAX, and the View edit form warns you if it
   is still off.
4. Set **Items to display** as usual; that number becomes the batch size loaded
   on each scroll or button click.
5. In the Infinite Scroll pager settings you can adjust three things:
   - **Button text** — the label on the load‑more button (for example
     *Load More* or *Show more articles*).
   - **Automatically load content** — when on, the next page loads on its own as
     the reader scrolls to the bottom; when off, rows load only when the button
     is clicked.
   - **Initially load all pages** — when on, every page up to the current one
     loads on first render, so deep‑linking directly to page 3 still shows pages
     1–3.
6. Save the View and visit its page — scroll down (or click the button) and the
   next batch of results appends in place.

To change how the pager looks, override the `views-infinite-scroll-pager.html.twig`
template in your theme; the [`agent/`](../agent/start.md) theming notes cover the
markup and JavaScript library in detail.
