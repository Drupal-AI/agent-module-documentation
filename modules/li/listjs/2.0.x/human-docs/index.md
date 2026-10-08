# List.js — manual setup guide

**List.js** (`listjs`) integrates the tiny, dependency‑free
[List.js](https://listjs.com) JavaScript library with Drupal to add instant
**client‑side** search, sorting, and filtering to a list, table, or almost any
HTML you already have on the page. Results appear as the visitor types — no page
reload, no round‑trip to the server, no query to run — the same feel as Drupal's
own Extend page, where the module list narrows the moment you start typing.

The module gives you the List.js library packaged for Drupal, a theme function
that builds filterable/sortable lists, and — through its **List.js Views**
submodule (`listjs_views`) — a way to add fast search on top of a Views list.

**When client‑side filtering is the right tool, and when it isn't.** This approach
shines when the entire set is small enough to send to the browser at once: a staff
directory of a couple hundred people, forty documents, thirty locations, a
glossary. It's genuinely better than an exposed Views filter, which costs a
request per keystroke or a submit button. But it only works when the whole list is
on the page. Client‑side filtering searches the DOM, so anything paged,
lazy‑loaded, or truncated is invisible to it — and a search box that silently
searches only page one of nine is worse than no search box, because the visitor
concludes the item isn't there. So the rule is: **send the whole list, or use a
server‑side filter.** That in turn bounds the size, since a page carrying two
thousand rows is slow to render and heavy on a phone no matter how fast the
filtering is.

Two things to keep in mind for quality: an input that changes results needs its
result count announced through a live region, or a screen‑reader user gets no
feedback; and filtered‑out rows stay in the DOM, so browser find‑in‑page and
assistive technology can still reach them unless they're properly hidden.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the List.js
   JavaScript library with Composer, and enable the optional Views submodule.

There is **no configuration page** for this module. It provides a library and a
theme function for developers/themers, plus per‑display settings on Views when you
use the List.js Views submodule.

## Where it lives in the admin menu

List.js adds no admin settings page. Developers attach the `listjs` library in a
custom or contributed module/theme, or use the module's theme function to build a
filterable list. If you enable **List.js Views**, the fast‑search behavior is
configured on the individual View display at **Structure → Views**.
