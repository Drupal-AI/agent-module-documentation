# Date Pager — manual setup guide

**Date Pager** (`date_pager`) is a **Views pager** that moves through *time*
instead of through numbered pages. For date‑organised content — an events listing,
a news archive, a calendar — numbered paging is the wrong metaphor: nobody asks
for "page 3 of the events," they ask for "next month." Date Pager makes the unit
of navigation a period, so the view shows what falls in the current period and the
next/previous links jump to the adjacent one.

The granularity is flexible — you can page by **year, month, day, or hour** — and
it supports the common date field types: `datetime`, `daterange`, the `changed`
and `created` entity fields, and **Smart Date**. A nice side benefit is that each
period gets a stable, meaningful URL (`?month=2026-09` rather than `?page=2`),
which makes the page linkable, bookmarkable, and better for SEO, because a month
doesn't change meaning when new content is added the way "page 2" does.

You use it by picking **Date pager** as the pager type in the Views UI and telling
it which date field and granularity to page by — there's no separate settings page.
It depends on core's **Views** module. Two things to think through when you set it
up: how empty periods should behave (a month with no content can render an empty
page or skip ahead to the next period that has content), and, on a large content
set, making sure the date field is indexed, since paging by date runs a range query
rather than a numbered offset.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views.

There is **no configuration page** — you select and configure the pager inside the
Views UI, as described below.

## How to use it

1. Edit (or create) a View that lists date‑bearing content under **Structure →
   Views**.
2. In the **Pager** section of the View, click the current pager type and choose
   **Date pager**.
3. In the pager settings, choose the **date field** to page by and the
   **granularity** (year, month, day, or hour) that suits your content.
4. Save the View. The pager's next/previous links now step through periods, and the
   URL carries the current period.
