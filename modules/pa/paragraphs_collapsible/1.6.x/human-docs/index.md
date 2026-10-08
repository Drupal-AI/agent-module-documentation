# Paragraphs Collapsible — manual setup guide

**Paragraphs Collapsible** (`paragraphs_collapsible`) makes long stacks of
Paragraphs easier to edit. On a node (or other entity) edit form that uses the
**classic** Paragraphs widget, it folds each paragraph item down to its title so
you can see the whole structure at a glance instead of scrolling through dozens
of open sub‑forms. It adds a per‑row `[+]` / `[-]` toggle to every paragraph that
has a title, plus an **Expand all / Collapse all** button on the field label.

This is a small, **zero‑configuration** front‑end enhancement. The moment you
enable it, the collapsible controls appear wherever the classic Paragraphs table
widget renders — there is no settings form, no permissions, and nothing to turn
on. It only touches the editing UI; the way paragraphs are displayed to visitors
is unchanged. Rows that contain a validation error, or that you just added with
the *Add* button, are auto‑expanded so you never lose sight of what needs your
attention. The module depends only on the [Paragraphs](https://www.drupal.org/project/paragraphs)
module.

One thing to know up front: the toggles only work on the **classic** Paragraphs
widget (the one whose machine name is `entity_reference_paragraphs`). The modern
"Paragraphs" (stable) widget already has its own collapse behavior, so this module
deliberately leaves it alone. To benefit, a Paragraphs field's *Manage form
display* setting must use the classic widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. After enabling the module:

1. Make sure the target Paragraphs field uses the **classic** widget. On the
   host bundle's *Manage form display* page (for example
   `/admin/structure/types/manage/page/form-display`), the field's widget should
   be **Paragraphs (Classic)** / `entity_reference_paragraphs`.
2. Edit any content that uses that field. Each paragraph row with a title now
   shows a `[+]` / `[-]` toggle, and the field label carries an **Expand all /
   Collapse all** button.
3. Click a row's toggle to fold or unfold just that paragraph, or use the field
   label button to collapse or expand every row at once — handy for reordering a
   long list by dragging the now‑compact rows.

If you want to restyle the toggles, override the CSS in
`css/paragraphs_collapsible.widget.css` from your own theme.
