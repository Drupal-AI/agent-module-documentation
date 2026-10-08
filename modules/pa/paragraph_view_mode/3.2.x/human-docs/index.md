# Paragraph View Mode — manual setup guide

**Paragraph View Mode** (`paragraph_view_mode`) lets a content editor choose, per
paragraph item on the edit form, **which view mode that paragraph renders in**. That
means one paragraph type can be reused with several different visual presentations
instead of building a separate paragraph type for each look. A single "Card"
paragraph can be shown as a wide card, a compact card, or a teaser; a "Quote" can be a
pull-quote or an inline quote — the editor picks per item from a dropdown.

The payoff is fewer near-duplicate paragraph types (and less field duplication) on
big sites. You define the presentations once as normal Drupal view modes, decide
which of them editors are allowed to choose, and the module adds a small **view mode**
select to the top of each paragraph on the edit form. At render time it quietly swaps
the paragraph's display to the editor's choice.

There's an optional advanced touch: you can **bind the form mode** to the view mode,
so choosing "compact" can also switch the paragraph's *edit* form to a matching form
mode (hiding fields that a compact rendering ignores). The module is careful to leave
Paragraphs' own back-end preview alone unless you opt in.

Setup is per paragraph type: there's **no central settings page**. You turn the
feature on with a checkbox on the paragraph type's edit form, then tune the allowed
view modes on **Manage form display**. It requires the
[Paragraphs](https://www.drupal.org/project/paragraphs) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enabling the feature on a paragraph
   type and choosing which view modes editors can pick.

## Where it lives in the admin menu

There's no dedicated settings page. You work on the Paragraphs screens:

- **Structure → Paragraphs types → *(type)* → Edit**
  (`/admin/structure/paragraphs_type/<type>`) — the on/off checkbox.
- The type's **Manage form display** tab — the view-mode select's settings.

## How to use it

Enable the feature on a paragraph type, make sure the view modes you want to offer are
turned on for that type (under its **Manage display → Custom display settings**), then
set the allowed view modes on **Manage form display**. Editors then get a "Paragraph
view mode" dropdown on each paragraph. Full details are in
[Configuration](configuration/index.md).
