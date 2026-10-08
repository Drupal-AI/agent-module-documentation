# Custom View Filters — manual setup guide

**Custom View Filters** (`custom_view_filters`) adds three ready-made Views filter
handlers that you can drop onto a node View without writing any code:

- an **A-Z (first-letter) filter** for building alphabetical directories and
  glossaries;
- a **granular date filter** that filters by year and/or month; and
- a **date-range picker** that filters between a "since" and an "until" date.

Each one behaves like any other Views filter: add it to a View, then in its
settings type the **machine name of the field** it should act on (for example
`field_fullname` or `field_build_date`). There is no field autodetection — you tell
the filter which field to use. All three can run either as an admin filter with a
fixed value you set in the View UI, or as an exposed filter that visitors control.
Because each exposed control is a normal form element, you can even print it
directly in a Views Twig template instead of using the default exposed-form block.

The module is deliberately minimal: it has no settings form, no permissions, and
no configuration of its own. Everything you configure lives inside the View you add
the filters to. Its only dependency is core's Views module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact handler
IDs and options — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere central — there is no settings page. The three filters appear inside the
Views UI (**Structure → Views**) whenever you add a filter to a node-based View,
under the filter group **Custom View Filters**.

## How to use it

1. Enable the module, then edit (or create) a View of content/nodes under
   **Structure → Views**.
2. In the **Filter criteria** section, click **Add**, and pick one of the filters
   from the **Custom View Filters** group:
   - **Custom AZ filter** — matches the first letter of a text field. Set
     **AZ field name** to the field's machine name (or the special value `title`).
     An operator option lets you match the first letter of the *first* word or the
     *second* word (handy for filtering surnames in a full-name field).
   - **Node granular date filter** — filters by year and/or month. Set the date
     field machine name (or the special `created` / `changed` timestamps). You can
     bound the selectable year range and use year-only, month-only, or year+month
     combinations.
   - **Date range picker filter** — a "since" and "until" pair. Set the date field
     machine name (or `created` / `changed`); leaving one bound empty simply omits
     it from the query.
3. Decide whether the filter is **exposed** (visitors control it) or a fixed admin
   filter, using Views' standard "Expose this filter" toggle. For the A-Z filter,
   the exposed control can allow single or multiple letter selection.
4. Save the View.

To render an exposed control inside a custom Views template rather than the default
exposed-form block, print it by its exposed identifier, for example:

```twig
{{ form.custom_az_filter }}
{{ form.nodes_granular_dates }}
{{ form.date_range_picker }}
```
