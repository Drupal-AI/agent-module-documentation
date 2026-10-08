# Contextual Filter Referer — manual setup guide

**Contextual Filter Referer** (`contextual_filter_referer`) fixes a specific,
maddening Views problem: a block View that loses its contextual‑filter argument
after an AJAX request. A View placed as a block usually takes its argument from
the page it sits on — a node ID, a term ID, a path component. But when the visitor
clicks the pager (or submits an exposed filter) and the View reloads over AJAX,
the request no longer comes from that page; it comes from Views' AJAX endpoint,
where the original argument is gone. The result is a view that is correct on page
one and wrong on every page after — the classic "the pager is broken" bug report.

This module resolves the argument from the **referring page** (the `Referer`
header) instead of the current request, so the context survives the AJAX round
trip. You enable it and then pick one of its two provided contextual‑filter
options — they behave just like their standard counterparts, but read their value
from the referer URL rather than the current URL. It depends only on core
**Views**.

One caveat is worth stating plainly. `Referer` is a client‑supplied header: it can
be absent (privacy settings, some proxies, and certain navigation strip it) or
forged. That is harmless for presentation — filtering a listing to "articles in
this section" — but it must **never** be used as a filter that is doing the work
of an access check, because then a client‑controlled header would be deciding what
is shown. Use it for context, not for access, and decide what your View does when
there is no referer at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You choose its filter options
inside the Views UI, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely inside the Views UI at
**Structure → Views** (`/admin/structure/views`), when configuring a display's
contextual filters.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the View whose pager or AJAX reload is losing its argument, at
   **Structure → Views**.
3. On the display's contextual filter, choose one of the two referer‑based options
   this module provides instead of the standard equivalents. Configure it just as
   you would the standard version.
4. Under **When the filter value is NOT available**, decide the fallback behaviour
   for when no referer is present — an argument with no default produces either
   *everything* or *nothing*, and both can surprise you.
5. Save the View and test the pager, including with a referer‑stripping browser,
   to confirm the context now survives past page one.
