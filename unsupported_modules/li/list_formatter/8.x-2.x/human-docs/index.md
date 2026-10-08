# List Formatter — manual setup guide

**List Formatter** (`list_formatter`) is a field display formatter that renders a
field's values as an HTML list — an unordered list (`<ul>`), an ordered list
(`<ol>`), or a comma‑separated inline list — instead of the default per‑item
markup Drupal produces. For a multi‑value field, each value becomes its own list
item; for a long‑text field, each line becomes a list item.

It works on most core field types (plain text, long text, number, List, taxonomy
reference, and more) and some contributed fields. There is nothing to configure
site‑wide: you simply choose the formatter on a field's *Manage display* screen,
and the values then follow Drupal's normal field sanitization, so it plays no
content or access‑control role.

This module was previously known as *textformatter*. It depends only on core's
Field module, and it is minimally maintained (maintenance fixes only), which is
fine for a small, stable formatter like this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
apply it per field on *Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

List Formatter adds no admin page of its own. You use it entirely from **Structure
→ Content types (or any fieldable entity) → *(bundle)* → Manage display**, where
it appears as a display format for eligible fields.

## How to use it

1. Go to the *Manage display* screen for the entity bundle that holds your
   multi‑value (or long‑text) field — for example **Structure → Content types →
   Article → Manage display**.
2. In the **Format** column for that field, choose **List formatter** (the exact
   label may read as a list option depending on the field type).
3. Click the gear/cog icon to open the formatter settings, where you can pick the
   list type — unordered (`<ul>`), ordered (`<ol>`), or a comma‑separated inline
   list — and any related options.
4. Click **Update**, then **Save**. The field now renders as a list wherever that
   view mode is used.
