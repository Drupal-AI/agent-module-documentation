# Views Selective Filters — manual setup guide

**Views Selective Filters** (`views_selective_filters`) makes an exposed Views
filter show only the option values that actually appear in the current result set.
Normally an exposed "Category" or "Type" dropdown lists every possible value, and a
visitor can pick one that returns an empty page. With this module, the dropdown is
trimmed to just the values in use — no dead options.

It works by adding a **"… (selective)"** variant of every filterable field in
Views. You add the field you want to filter on to your view, then add the matching
"(selective)" filter and expose it. Behind the scenes the module re-runs a copy of
the view to collect the distinct values present, and limits the exposed options to
that set. This gives you facet‑like behavior without installing a full facets
stack.

Because it re‑runs the query to gather values, it is best suited to
**low‑cardinality** filters — content type, a small vocabulary, a status field —
rather than high‑cardinality free‑text fields. A built‑in safety limit rejects a
field that has too many distinct values.

There is **no settings page** — everything is configured per view in the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module has no configuration page of its own. You use it inside the **Views**
editor at **Structure → Views** (`/admin/structure/views`), when adding filters to
a view.

## How to use it

In the Views UI, on the view you want to enhance:

1. **Add the field** you want to filter on (for example *Content: Type*, or a
   taxonomy term reference). Configure its output; tick **"Hidden from display"** if
   you do not want it shown in the rows.
2. **Add a filter** and choose the entry ending in **"(selective)"** — for example
   *"Type (selective)"*. These are the variants the module injects.
3. In the filter settings, **expose** the filter. If the selective filter is not
   offered or throws a mismatch error, the filter and the field from step 1 are not
   compatible — pick a matching pair (they must share the same base field).

The selective filter has a few options you can set:

- **Display field** — which added view field supplies the human‑readable option
  labels.
- **Sort** — the order of the offered options: ascending, descending, by key, none,
  or "as the original filter."
- **Items limit** *(default 100)* — if the field has more than this many distinct
  values, it is treated as unsuitable for a selective filter. This guard exists
  precisely because the module re‑runs the query to gather values; keep selective
  filters on low‑cardinality fields.

Save the view. When visitors use the exposed filter, they will only see options
that return results.
