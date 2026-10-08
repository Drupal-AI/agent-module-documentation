# Comma Separated String Widget — manual setup guide

**Comma Separated String Widget** (`comma_separated_string_widget`) adds a field
widget that lets editors type several values into one text box, separated by
commas, instead of filling in a separate row for each value. When the entity is
saved, the widget splits the input on commas and stores each piece as its own
value in a multi‑value string field. It's a small quality‑of‑life improvement for
anyone who regularly enters lists of short values — tags, codes, keywords — and
finds the default "one row per value" interface slow.

This is purely a content‑editing convenience. It changes only how values are
*entered*; the values themselves are stored normally, exactly as any other
multi‑value string field would store them. It has no content model or
access‑control role, adds no admin settings page, and works on Drupal 9, 10, and
11 with no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you simply choose the widget
on a field's *Manage form display*, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings form. You select the widget per field under
**Structure → Content types → *(type)* → Manage form display**
(`/admin/structure/types/manage/*/form-display`), or the equivalent Manage form
display for any other fieldable entity.

## How to use it

1. Add (or reuse) a **multi‑value** string / plain‑text field on your content type
   or other entity — set the field's *Allowed number of values* to more than one
   (or Unlimited), since that is what makes the comma‑separated entry useful.
2. Go to that bundle's **Manage form display**.
3. For your multi‑value string field, change the **Widget** to **Textfield
   (comma separated values)** and save.

Editors will now see a single text box for that field. They type values separated
by commas — for example `red, green, blue` — and on save the module stores three
separate values.
