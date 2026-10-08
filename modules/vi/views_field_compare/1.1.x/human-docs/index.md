# Views Field Compare — manual setup guide

**Views Field Compare** (`views_field_compare`) adds two Views filter plugins
that let you filter a view by comparing *two of the view's own fields against
each other* — instead of comparing a field to a fixed value you type in. Want
only the rows where a start date is earlier than an end date, or where "quantity
ordered" does not equal "quantity shipped"? This module lets you express that
directly inside the Views UI, with no custom code.

It registers the two filters under the Views **Global** filter category, so they
appear alongside core's other global filters when you add a filter criterion to a
display. **Field comparison** compares two single-valued fields with a relational
operator (`<`, `<=`, `=`, `!=`, `>=`, `>`). **Field contained** checks whether a
single-valued field's value is *in* (or *not in*) the set of values held by a
multi-valued field. In both cases you pick the two fields from drop-downs that
list the fields already added to your view, and the comparison is turned into an
SQL expression at query time.

A few things to know up front: both filters are chosen by the view builder at
configuration time — they cannot be exposed to end users, and they cannot be
grouped. The two fields you compare must both be present in the display (you can
hide them with *Exclude from display* so they don't actually show). If a chosen
field goes missing, the view safely returns no rows rather than leaking an
unfiltered list. Because the comparison happens in SQL with limited type casting,
the two fields should hold compatible value types.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page — this module has no configuration of its own.
Everything is done inside a View at **Structure → Views**
(`/admin/structure/views`).

## How to use it

1. Edit (or create) a View at **Structure → Views**. The display must use
   **fields** (a "fields" row style), not entity rendering.
2. Add the two fields you want to compare to the display's **Fields** section. If
   you don't want them shown, edit each one and tick **Exclude from display** —
   they only need to *exist* in the display, not appear.
3. In the display's **Filter criteria**, click **Add**, choose the **Global**
   category, and pick either:
   - **Field comparison** — then choose a *left* field, an operator (`<`, `<=`,
     `=`, `!=`, `>=`, `>`), and a *right* field. Only click-sortable (simple)
     fields are offered. The view keeps only rows where
     `left <operator> right` holds.
   - **Field contained** — then choose a *left* (single-valued) field and a
     *right* **multi-valued** field, plus *Is contained in* or *Is not contained
     in*. The view keeps only rows where the left value is (or isn't) among the
     right field's values.
4. Save the view. The comparison is applied in the database query, so it works
   across pagination and combines cleanly with your other Views filters.

Tips:

- For **Field comparison** you need at least two click-sortable fields in the
  display, otherwise the filter reports an error.
- For **Field contained**, the two fields should belong to the same entity type
  so the underlying sub-query can correlate them correctly.
- Only the operators listed above are available — the value being compared always
  comes from another field, never from user input.
