# Reference Date — manual setup guide

**Reference Date** (`reference_date`) provides a single, combined field type that
stores an **entity reference together with a start date** — and, optionally, an
end date — all in one field. Instead of modelling "an item plus a date" with a
Paragraph or a dedicated entity (each of which adds its own tables, forms and
joins), you add one **Reference Date Combo** field and get both halves in a
single delta.

The field type is called `reference_date_combo` and it extends Drupal core's
entity-reference field, so you still pick a target entity type and bundle exactly
as you would for a normal reference. On top of that it adds a start-date column
and an optional end-date column. Its purpose is to reduce database and query
bloat: when all you need is "this reference, on this date," keeping the pair in
one field keeps your Views and queries simple.

It works with any fieldable entity and depends only on core's **Datetime**
module. There is no settings page, no permission and no route — you configure
everything through Drupal's standard Field UI when you add the field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Everything is set up on the field itself, described in "How to use it" below.

## Where it lives in the admin menu

Reference Date adds no admin page of its own. You use it entirely from **Structure
→ Content types (or any entity bundle) → Manage fields**, where the **Reference
Date Combo** field type becomes available once the module is enabled.

## How to use it

1. Go to the bundle you want the field on — for example **Structure → Content
   types → Article → Manage fields** — and click **Create a new field**.
2. Choose the **Reference Date Combo** field type.
3. In the field's **storage settings** (these lock once data exists, so decide
   carefully):
   - **Date type** — `date` for a date only, or `datetime` for date and time.
   - **End date** — turn this on if each value should carry a start *and* an end
     date; leave it off for a single date.
   - Plus the usual entity-reference settings: which **target entity type** and
     **bundle(s)** the reference points at.
4. On **Manage form display**, the **Reference Date Combo** autocomplete widget
   lets editors pick the referenced entity and enter the date(s) together.
5. On **Manage display**, choose the **Label** formatter. It renders the
   referenced entity's label alongside the formatted date(s) as HTML `<time>`
   elements. In the formatter settings you can pick the **date format** and,
   optionally, a **timezone override** for how the date is displayed.

Both a reference target and a start date are required by the field's built-in
constraints, so a value cannot be saved with one half missing. This makes the
field a tidy way to model event-like data — an item paired with a date or a
date range — without reaching for Paragraphs or ECK.
