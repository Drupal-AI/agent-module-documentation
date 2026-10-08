# Field Display Label — manual setup guide

**Field Display Label** (`field_display_label`) lets a field show a *different
label when its content is viewed* than the label editors see on the entry form.
For example, a field labelled "Body" on the edit form can render as "Article
text" on the page — without renaming the field, changing its machine name, or
touching a Twig template.

It does this by adding a single **Display label** textfield to the standard field
settings form. Whatever you type there is saved as a per-field setting, and when
the field is rendered the module quietly swaps in that label instead of the normal
one. Leave the box blank and the field keeps its usual label. Because the value is
stored per field *instance* (per bundle), the same reused field can display a
different label on each content type — "Related item" on one type, "Source" on
another.

The module works the moment you enable it — there is no settings page and nothing
to switch on. It depends only on core's **Field** module, ships no submodules, no
permissions of its own, and no Drush commands. Its whole job is that one extra
textfield plus the label swap at display time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens on each field's own
settings form, under **Structure → (content type / bundle) → Manage fields**.

## How to use it

1. Go to the bundle's **Manage fields** — for example an Article at
   `/admin/structure/types/manage/article/fields`.
2. Click **Edit** on the field you want to relabel. This opens the normal field
   settings form.
3. Find the new **Display label** field, which sits just below the standard
   **Label** field. Its help text reads: *"A separate label for viewing this field.
   Leave blank to use the default field label."*
4. Type the label you want visitors to see (e.g. "Article text") and click
   **Save settings**.

From then on, the field renders with your display label on the page while the edit
form keeps its original label. To go back to the default, edit the field again and
clear the **Display label** box. Repeat per content type if you want a shared field
to read differently in different places.
