# Facets Range Datepicker Widget — manual setup guide

**Facets Range Datepicker Widget** (`facets_range_datepicker_widget`) adds
calendar‑based date widgets to the
[Facets](https://www.drupal.org/project/facets) module, so a date facet can be
filtered with a from/to picker rather than a long list of individual date links.
Faceted search over dated content — events, articles by publish date, records by
timestamp — really wants a date‑range control, the way major search engines offer
one, and this module provides exactly that.

It installs two facet widgets: **Datepicker**, for selecting documents on a single
day, and **Range Datepicker**, for selecting a span across multiple dates. The
visitor picks the date (or the from/to span) on a calendar and the facet narrows
the results accordingly.

It plugs into Facets as a widget, so it needs a Search API index with a **date
field** exposed as a **range facet** — the widget presents whatever that facet is
configured to provide. It is a UI enhancement with no security surface of its own:
it simply renders a picker over what the facet already exposes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no central configuration page** for this module — you choose the widget
on each date facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Range Datepicker Widget adds no admin page of its own. You select its widgets
from the **Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet.

## How to use it

1. Make sure a **date field** is exposed on your Search API index and that you have
   a **range facet** built on it (the widget presents what the range facet
   provides).
2. Edit that facet at **Configuration → Search and metadata → Facets** and choose
   the **Datepicker** widget (single day) or **Range Datepicker** widget (a date
   span).
3. Save, then load the page with the facet and confirm the calendar picker renders
   and that choosing a date (or from/to span) narrows the results.
