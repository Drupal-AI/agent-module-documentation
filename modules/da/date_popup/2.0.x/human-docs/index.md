# Date Popup — manual setup guide

**Date Popup** (`date_popup`) replaces the plain text date inputs in Views exposed
filters with native HTML5 date (and datetime) pickers. Instead of asking visitors
to type a date in exactly the right format, your exposed date filters render a
browser calendar widget — friendlier, more accessible, and much less prone to
"invalid date" errors.

The module is tiny and, importantly, has **no configuration at all**. On install
it quietly alters the Views filter registry to swap the class of the core `date`
and `datetime` filters — and the Search API `search_api_date` filter when Search
API is present — for its own subclasses. Those subclasses render the exposed form
element as an HTML5 `date` (or `datetime-local`) input, so users get a native
calendar picker automatically.

The upshot is that any exposed date filter, on any View, becomes a calendar
picker with no per‑View setup beyond exposing the filter. It supports both core
datetime fields and Search API date filters, and works across Drupal 8 through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is **no settings page** — nothing to configure. Date Popup works globally the
moment it is enabled. The only place you interact with its effect is inside the
**Views** UI (`/admin/structure/views`), where exposed date filters now render as
pickers, and on the front end where visitors use them.

## How to use it

There is genuinely nothing to set up beyond enabling the module:

1. Install and enable Date Popup (see [Installation](installation/index.md)).
2. On any View, add a filter on a date or datetime field (or a Search API date
   filter) and **expose** it.
3. Visit the View — the exposed date filter now shows a native HTML5 calendar
   picker instead of a free‑text box.

This works for the usual date operators too (greater than / less than, and "between"
date‑range filters), and the picker follows the visitor's browser locale for date
formatting. It is the quickest way to modernize legacy date filters — for example
when filtering a blog archive by publication date, or a report by a start/end date
range — without writing any custom form‑alter code.
