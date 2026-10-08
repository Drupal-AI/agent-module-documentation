# Views Dependent Filter — manual setup guide

**Views Dependent Filter** (`views_dependent_filters`) adds a special Views filter,
**"Global: Dependent filter"**, that shows or hides *other* exposed filters based on
what a visitor has selected in a controlling filter. It's a way to give an exposed
filter form **progressive disclosure** — irrelevant filters only appear once they
apply — with no custom JavaScript and no query overhead.

A typical example: a product catalog with a "Product type" filter. You only want the
"Cake flavour" filter to appear when "Cake" is selected, and the "Book genre" filter to
appear when "Book" is selected. You add a Dependent filter handler that watches the
"Product type" filter (the *controller*) and reveals the appropriate *dependent* filters
when the right value is chosen. Other uses include cascading location filters
(country → region → city), hiding advanced filters behind a toggle, or only showing a
date-range filter when a "search by date" checkbox is ticked.

The handler does no querying itself and takes no input — it simply wires up Form API
`#states` so the browser shows and hides the dependent filters. Hidden dependents are
ignored when the form is submitted, so they don't accidentally constrain your results.
It works with the standard Views exposed form, with **Better Exposed Filters**, and has
special handling for **Facets** filters.

This guide is written for a **human** building a view in the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

The module has no settings page. You configure everything per-view inside the **Views
UI** (**Structure → Views**, `/admin/structure/views`) by adding and setting up the
"Global: Dependent filter" handler.

## How to use it

The key idea is that the **order** of filters in the view decides who controls whom:
the controller filter must come **before** the Dependent filter handler, and the
dependent filter(s) must come **after** it. So the order reads:

> controller filter → **Dependent filter handler** → dependent filter(s)

To set one up:

1. Edit your view and make sure the controlling filter and the filter(s) you want to
   show/hide are both added and **exposed**, in that order.
2. Under **Filter criteria**, click **Add**, search for **Global: Dependent filter**,
   and add it. Place it *between* the controller and the dependents.
3. On the first settings screen, pick the **Controller filter** — only filters earlier
   in the order are offered.
4. On the main settings screen, choose:
   - **Condition mode** — *"Filter is set to specific values"* (you then pick which
     controller values trigger visibility) or *"Filter is selected / not empty"* (any
     value triggers it).
   - **Controller values** — for the "specific values" mode, which values reveal the
     dependents (the module reuses the controller's own value widget so you pick from
     its real options).
   - **Dependent filters** — tick the later exposed filters to show or hide.
   - **Negate** — invert the logic, so the dependents are *hidden* when the condition is
     met instead of shown.
5. Save the view.

You can add several Dependent filter handlers to one view — one per controller — so each
controlling filter reveals its own set of dependents. It works on top of **Better
Exposed Filters** widgets, and for a **Facets** controller you provide the triggering
values as a comma-separated list (facet options only exist after the search runs).
