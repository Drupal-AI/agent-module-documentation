# Facets Date Range widget — manual setup guide

**Facets Date Range widget** (`facets_date_range`) adds a **Date Range Picker**
to the [Facets](https://www.drupal.org/project/facets) module, so visitors can
narrow search results by a minimum and/or maximum date using two compact date
inputs — instead of scrolling a long list of individual date facet links. It is
ideal for filtering articles by publish date, an events listing by event date, or
any Search API results that carry a date field.

The module ships two Facets plugins that work together: a **widget** that renders
the two "from" / "to" date inputs (with customisable labels) and rewrites the
facet URL client‑side as the user changes the dates, and a matching **processor**
that turns the chosen dates into a range query for the search backend. You can
leave either end open — a "from" date alone filters everything after it, a "to"
date alone filters everything before it.

The module requires the **Facets** module (it works with Facets 1.6, 2.x, or
3.x) and PHP 7.4 or newer; Composer installs Facets for you. It has **no
configuration page of its own** — you set everything up per facet on the normal
Facets edit form. It has no permissions and no submodules, and works on Drupal
8.9 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the widget and
processor internals — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no page of its own. You configure the date‑range facet under
**Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`), on the edit form of an individual facet.

## How to use it

Set the date‑range picker up on any existing facet whose underlying field is a
date or timestamp (range comparison only makes sense on a date field):

1. Go to **Configuration → Search and metadata → Facets** and edit the facet you
   want.
2. Set the **Widget** to **Date Range Picker**. Optionally change the two input
   labels (they default to **Date from** and **Date to**).
3. Under **Processors**, enable **Date Range Picker**. This processor is required
   for the widget to work — the widget's settings form reminds you to turn it on.
4. Optionally tick **Include through end of max date** so results on the max date
   itself are included (otherwise the max is treated as the start of that day).
5. Save the facet.

The facet now shows two date inputs. As the visitor picks dates, JavaScript
rewrites the facet URL to filter the results by the chosen range. You can combine
the date‑range facet with other facets on the same search and place it in a block
or inline facet region like any other facet.
