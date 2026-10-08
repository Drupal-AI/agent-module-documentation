# Field Group Metadata — manual setup guide

**Field Group Metadata** (`field_group_metadata`) tidies up busy content editing
forms by moving a chosen group of "metadata" fields into the right‑hand sidebar
of the node form — the same column core already uses for authoring information,
promotion options, and the revision log.

On a content type with many fields, the ones that matter editorially (title,
body, images) end up interleaved with the ones that matter operationally
(internal reference numbers, review dates, filing taxonomy), and the form turns
into one long scroll. This module extends core's sidebar treatment to a field
group: any group you designate as metadata is relocated into that column when
the form is rendered, so editors see the primary content first and the
"housekeeping" fields sit neatly out of the way.

The change is purely presentational — nothing about how your data is stored
changes, and the arrangement exports with your form display configuration. The
module is tiny (essentially one pre‑render class) and depends only on the
[Field Group](https://www.drupal.org/project/field_group) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Field Group dependency.

There is **no configuration page** for this module — it has no settings form.
The one thing you must get right is the field group's **machine name**,
described in "How to use it" below.

## Where it lives in the admin menu

Field Group Metadata adds no admin page. You use it from **Structure → Content
types → *(your type)* → Manage form display**, where you create the metadata
group.

## How to use it

The module keys off a field group whose machine name is exactly
**`group_metadata`** — that is how it recognises which group to move into the
sidebar.

1. Go to your content type's **Manage form display** (the "Edit form display"
   page).
2. Click **Add group** and choose the **Details** group type.
3. Give the group a label, and make sure its **machine name is
   `group_metadata`** — this is required for the module to pick it up.
4. Save, then drag the metadata fields (internal references, review dates,
   filing taxonomy, and so on) inside the group.
5. Save the form display.

When you next open the content edit form, the `group_metadata` group appears in
the sidebar alongside core's authoring and revision sections, leaving the main
column for your primary content.
