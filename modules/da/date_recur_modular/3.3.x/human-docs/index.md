# Date Recur Modular Widget Framework — manual setup guide

**Date Recur Modular Widget Framework** (`date_recur_modular`) gives editors
friendlier, calendar‑app‑style form widgets for the **Recurring Dates Field**
(`date_recur`) field type — and a starter framework for building your own. On its
own, `date_recur` stores an RFC 5545 RRULE but only offers a bare RRULE textarea,
so an editor has to type strings like `FREQ=WEEKLY;BYDAY=TU,TH`. This module
replaces that box with guided UIs where editors pick "weekly on Tue/Thu until…"
instead.

It ships three widgets, all of which attach only to `date_recur` fields:

- **Modular: Alpha** (`date_recur_modular_alpha`) — a Drupal‑states + CSS widget
  supporting non‑recurring, multiday, weekly, and monthly (ordinal, e.g. "third
  Thursday") modes. No widget settings.
- **Modular: Oscar** (`date_recur_modular_oscar`) — an opening‑hours variant
  where the range stays within a single day, with an optional all‑day toggle.
- **Modular: Sierra** (`date_recur_modular_sierra`) — an AJAX/modal,
  Google‑Calendar‑style UI that can preview generated occurrences and exclude
  specific ones, using a `date_recur` interpreter to show human‑readable text.

You "configure" the module by choosing one of these widgets on an entity **form
display** — there is no global settings page. Note the README's own warning: the
widgets are deliberately minimal and are *not* meant to grow new features; if you
need more, copy a widget's code into your own module and adapt it, and pin the
version if you depend on one directly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its
   `date_recur` dependency) with Composer and enable it.

## Where it lives in the admin menu

There is **no settings page of its own**. You assign one of its widgets to a
`date_recur` field under **Structure → Content types → (your type) → Manage form
display** (`/admin/structure/types/manage/{bundle}/form-display`).

## How to use it

1. Make sure you have a **Recurring Dates Field** (`date_recur`) on some bundle —
   this module adds widgets, not the field type itself.
2. Go to that bundle's **Manage form display**.
3. In the row for the `date_recur` field, pick a widget from the **Widget**
   select: **Modular: Alpha**, **Modular: Oscar**, or **Modular: Sierra**.
4. Click the gear icon to edit the widget's settings, then **Save**:
   - **Oscar** — *all‑day toggle* (on by default; turn it off when every entry
     must have times).
   - **Sierra** — *interpreter* (a `date_recur` interpreter used to render
     occurrence text; none by default), *date format* (default *medium*), and
     *occurrences modal* (on by default — the modal to preview/exclude
     occurrences).
   - **Alpha** has no settings.
5. **Permission:** the **Sierra** widget's modal forms require the
   **date_recur_modular use sierra form** permission. Grant it at **People →
   Permissions** to any role that edits fields using Sierra. Alpha and Oscar need
   no extra permission.

The widget change affects only how editors *enter* recurrence; the field's stored
RRULE format is unchanged, so you can switch an existing raw‑RRULE field to a
friendlier widget without migrating data.
