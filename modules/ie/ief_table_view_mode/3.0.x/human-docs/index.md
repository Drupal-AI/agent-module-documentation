# IEF Table View Mode — manual setup guide

**IEF Table View Mode** (`ief_table_view_mode`) gives you control over the
**columns** shown in the Inline Entity Form (IEF) table. Inline Entity Form is a
popular module that lets editors create and edit *referenced* entities right
inside a parent form — for example, adding line items to an order, or paragraphs
to a page — and it lists those referenced entities in a table. Normally you have
little say over which fields appear as columns in that table. This module lets
you decide.

It adds a new IEF widget whose table columns are driven by a dedicated **view
mode** called *Inline Entity Form Table* (`ief_table`). Whatever fields you place
in that view mode on the referenced entity become the columns in the IEF table.
So you can show, say, a Title, a status, and a date as tidy columns instead of
IEF's default label-only row.

Setup happens in two places: on the *referencing* field you choose the new
widget, and on the *referenced* entity type you configure the `ief_table` view
mode to lay out the columns. There's no separate settings page — it all happens
through the standard Manage form display and Manage display screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Inline Entity Form) and enable it.

## Where it lives in the admin menu

There is no central settings page. You work in two standard locations:

- The **Manage form display** page of the entity that *contains* the reference
  field (for example `/admin/structure/types/manage/article/form-display`).
- The **Manage display** page of the entity type the field *points at*, where
  the *Inline Entity Form Table* view mode is configured.

## How to use it

**Step 1 — Use the widget on your reference field.** On the entity that contains
the entity-reference (or entity-reference-revisions) field, go to **Manage form
display**, set that field's **Widget** to **Inline entity form - Complex - Table
View Mode**, adjust its settings (it accepts the same settings as IEF Complex —
allowed bundles, form mode, and so on), and click **Save**.

Saving that form display automatically creates a view mode named **Inline Entity
Form Table** (`ief_table`) for the referenced entity type, if it doesn't already
exist. (You could also create it by hand under **Structure → Display modes →
View modes**.)

**Step 2 — Configure the columns.** On the *referenced* entity type's **Manage
display** page, enable the **Inline Entity Form Table** custom display, switch to
that tab, and place and order the fields you want to appear. Each visible field
you configure there becomes a **column** in the IEF table. (Field labels are
hidden in the table itself, and IEF's own built-in columns are merged back in and
marked with a `*`.)

That's it — reload the parent form and the inline table now shows your chosen
columns. Note that while this module is enabled, the `ief_table` view mode can't
be deleted. If a referenced bundle has no enabled `ief_table` display, the widget
simply falls back to IEF's default columns.
