# Views Exposed Filters Summary — manual setup guide

**Views Exposed Filters Summary** (`views_filters_summary`) prints a plain-English
summary of the exposed filters a visitor currently has applied to a view —
something like *"Displaying 12 results for Red, Large"*. It's the "active
filters" bar you see on faceted search and product-listing pages, but built
entirely from a view's own exposed filters, with no separate facets module
required.

You add it to a view as an **area** — in the Header, Footer, or "No results"
region — and it renders a configurable sentence that counts the results and lists
each active filter's value in readable form. It's smart about translating raw
values into human text: taxonomy term IDs become term names, entity bundle
machine names become bundle labels, user IDs become display names, list/options
values become their labels, and range filters read as "min–max" or operator-aware
phrases like "Greater than 100" or "Not Red". Optionally each value gets a small
remove-"X" link, and the whole thing can carry a single "Reset" link that clears
all applied filters — both wired up with a small JavaScript library that updates
the exposed form on the fly, AJAX views included.

There is **no site-wide settings page**. You configure everything per view when
you add the area handler: which filters to include, whether to show labels, how
to group multi-value filters, the separator and prefix text, the singular/plural
result nouns, and whether to show the remove and reset links. It depends only on
core's **Views** module, and it ships eleven optional submodules that teach the
summary about filters provided by other modules (Address, Better Exposed Filters,
Commerce, Search API, Entity Browser, and more).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick any integration submodules you need.

## Where it lives in the admin menu

Nowhere on its own — this module adds no admin settings page. You work with it
inside the **Views UI** (`/admin/structure/views`), on individual view displays.

## How to use it

You need a view that has at least one **exposed** filter (a filter a visitor can
change from the page). Then:

1. Go to **Structure → Views** and edit that view (or add a new one).
2. In the **Header**, **Footer**, or **No results behavior** section, click
   **Add** and choose **Views exposed filters summary** (it's in the "Global"
   group).
3. Configure the area's options and **Apply**, then **Save** the view.

The options you can set on the area handler:

- **Content** — the sentence template. It defaults to
  `Displaying @total @result_label @exposed_filter_summary`, where `@total` is the
  result count, `@result_label` is your singular/plural noun, and
  `@exposed_filter_summary` is the rendered list of active filters. You can
  rearrange or reword this freely.
- **Filters** — choose which exposed filters appear in the summary. Leave it empty
  to include them all, or pick just the ones that matter (for example show
  Category and Price but not Sort).
- **Show labels** — prefix each value with its filter's label, e.g. "Color: Red".
- **Group values** — collect a multi-value filter's selections under a single
  label instead of listing each separately.
- **Show remove link** — add a small "X" next to each value so visitors can drop
  one filter without touching the others.
- **Show reset link** and **Reset link title** — add a single link (default text
  "Reset") that clears every applied exposed filter at once.
- **Summary prefix** — text placed before the filter list (default "for ").
- **Summary separator** — what goes between items (comma, slash, etc.).
- **Result label** — the singular and plural nouns for the count, e.g. "1 product"
  / "12 products".

The summary hides itself when there's nothing useful to show (for example when
the view has no results and you haven't asked it to count zero).

### Extending it for custom filters

Values from taxonomy, bundle, user-name, and list/options filters are resolved to
readable labels automatically. If you have a custom filter plugin the summary
doesn't recognize, developers can teach it using the module's family of alter
hooks (`hook_views_filters_summary_*`) — which is exactly how the optional
submodules add support for Address, Commerce, Search API, and the rest.
