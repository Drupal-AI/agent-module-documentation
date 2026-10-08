# Text Summary Options — manual setup guide

**Text Summary Options** (`text_summary_options`) adds a few helpful site-builder
options to Drupal's **Text (formatted, long, with summary)** fields — the field
type behind the article *Body*, where an editor can write a full text plus a
shorter summary/teaser.

By default, that summary is tucked away behind an "Edit summary" link, has no
help text, and no placeholder. This module lets you improve the editing
experience for each such field with three settings: show the summary box
expanded by default, add your own help text under it, and add placeholder text
inside it. These are small touches, but they make the summary far more
discoverable so editors actually write good teasers.

The settings live on the **field itself** (its configuration), not on a separate
admin page, and they only appear for fields of type *Text (formatted, long, with
summary)*. They affect only the editing form — the stored content is untouched.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. The options appear on the **edit form of each
text-with-summary field**, under **Structure → Content types → (your type) →
Manage fields → (edit the field)**, for example
`/admin/structure/types/manage/article/fields/…` for the Body field.

## How to use it

1. Go to **Manage fields** for the bundle and click **Edit** on a *Text
   (formatted, long, with summary)* field such as **Body**.
2. On the field edit form you'll now find three new options:
   - **Show summary** — when ticked, the summary textarea is shown expanded by
     default instead of hidden behind the "Edit summary" link, so editors see it
     right away.
   - **Summary help text** — text shown underneath the summary box to guide
     editors (for example, "Write a one-line teaser.").
   - **Summary Placeholder** — greyed-out placeholder text shown inside the empty
     summary box (for example, "e.g. A short teaser...").
3. Fill in the ones you want and click **Save settings**.

Leave any option blank (or untick **Show summary**) to fall back to core's normal
behavior for that aspect.
