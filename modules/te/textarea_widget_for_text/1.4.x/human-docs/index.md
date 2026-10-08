# Textarea Widget For Text Fields — manual setup guide

**Textarea Widget For Text Fields** (`textarea_widget_for_text`) does one small,
useful thing: it lets ordinary **short text fields** use a multi‑row **Text area**
widget on edit forms, instead of being stuck with a single‑line input. Core only
offers the textarea widget to "long" text fields, so a plain string field or a
single‑line formatted text field normally can't grow beyond one line in the editing
UI — even when the content logically spans a few lines (an address block, a
subtitle, a short note). This module removes that limitation.

It is deliberately tiny: the whole module is a single line of Drupal "glue" that
makes core's `Text area (multiple rows)` widget selectable for short `string` and
`text` fields. It stores its short‑text values exactly as before — only the editing
box changes. There is no settings page, no configuration object, no permission, and
no Drush command; the only lasting effect is the widget you pick on the field's
form display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, switch the widget on the field's form display:

1. Go to **Manage form display** for the bundle that has the short text field (for
   example `/admin/structure/types/manage/article/form-display`).
2. On the short text field's row, change the **Widget** from *Textfield* to **Text
   area (multiple rows)**.
3. Click **Update**, then **Save**.

The field now shows a roomy multi‑line box. You can set the usual textarea widget
options — the number of **rows** and a **placeholder** — via the widget's cog. It
works anywhere fields are configured: content types, users, comments, taxonomy
terms, media, and so on, and you can even use the textarea on the default form mode
while keeping a plain textfield on another.

To revert later, just switch the field's widget back to *Textfield* — and you can
then disable the module.
