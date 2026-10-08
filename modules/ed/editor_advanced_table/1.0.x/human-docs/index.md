# Editor Advanced Table — manual setup guide

**Editor Advanced Table** (`editor_advanced_table`) enriches the tables your
editors create in **CKEditor 5**. Out of the box, CKEditor 5 lets an author
insert and resize a table, but it does not let them put an **ID**, a **language
direction**, or **CSS classes** on that table. This module adds those three
attributes to the Table Properties dialog, so editors can produce more precise,
themeable table markup without dropping into source view.

Inspired by the popular *Editor Advanced Link* module, it works the same way:
you decide, per text format, which of the three attributes editors are allowed to
set. It depends only on core's **CKEditor 5** module.

Because this is a content-authoring feature, remember that the attributes an
editor adds still pass through your **text format's filters** on output. If your
format restricts allowed HTML, make sure the `class`, `id`, and `dir` attributes
are permitted on `<table>` (and not stripped by a sanitiser), or the extra markup
will be discarded when the content is displayed. The module has no access-control
role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings page** for this module. You turn its attributes
on inside each text format's CKEditor 5 plugin settings, described in "How to use
it" below.

## Where it lives in the admin menu

Editor Advanced Table adds no admin page of its own. You configure it from
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), inside the CKEditor 5 settings of the format
you want to enhance.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format your editors use (for example *Full HTML*) and click
   **Configure**.
3. In the **CKEditor 5 plugin settings** area, open the **Advanced table** tab.
4. Enable the attributes you want editors to be able to set on tables — **class**,
   **id**, and/or **dir** (language direction).
5. Save the format.
6. If the format limits allowed HTML, confirm that the attributes you enabled are
   permitted on `<table>` so they survive filtering on output.

Now, when an editor inserts or edits a table in that format and opens its
properties, they can set an ID, choose a direction, and apply CSS classes.
