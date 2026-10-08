# Configuration

Entity Reference Tree has no global settings page. You configure it per field on
that field's **form display**, where you pick the tree widget and adjust its
options.

## Enable the widget on a field

1. The field must be an **entity reference** field. If you don't have one yet,
   create it under **Structure → *(entity type)* → Manage fields**.
2. Go to that bundle's **Manage form display** — for example, for the Article
   content type: **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
3. In the **Widget** column for your reference field, choose **Entity reference
   tree widget**.
4. Click the gear icon to open the widget settings (see below), adjust as needed,
   click **Update**, then **Save**.

## Widget settings

The gear icon exposes these options:

- **Theme** — the jsTree theme for the tree. Use `default`, or `default-dark` to
  match a dark admin theme.
- **Dots** — set to show connector dot lines linking parents and children in the
  tree.
- **Worker** — enables the jsTree web worker, which helps when rendering very
  large trees.
- **Disable animation** — turns off the tree's open/close animation.
- **Force text** — the jsTree `force_text` option (renders node labels as plain
  text).
- **Label** — the text on the picker **button** the editor clicks. Defaults to
  "*(Type)* tree".
- **Dialog title** — the title shown at the top of the modal dialog. Defaults to
  the button label.
- **Placeholder** — placeholder text for the autocomplete text field.
- **Match operator** — how the autocomplete matches typed text (CONTAINS or
  STARTS_WITH).
- **Match limit** — the maximum number of autocomplete suggestions to show.
- **Size** — the width (size) of the autocomplete text field.
- **Autocomplete max length** — the maximum length of the autocomplete input
  (default 1024).

Because the widget extends core's autocomplete widget, the plain text field and
tags behavior are inherited; the tree button and modal are the additions. Whatever
you select in the tree is constrained to the field's configured target bundles.

The settings are stored in the bundle's form-display configuration, so they export
and deploy like any other form-display change.

## For developers

You can add a tree builder for a non-taxonomy entity type by tagging a service
`entity_reference_tree_builder`, and customize how each taxonomy term's label
appears with `hook_entity_reference_tree_create_term_node_alter()`. See the
[`agent/`](../agent/start.md) docs for both.
