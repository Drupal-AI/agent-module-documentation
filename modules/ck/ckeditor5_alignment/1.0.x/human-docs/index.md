# CKEditor5 Alignment Buttons — manual setup guide

**CKEditor5 Alignment Buttons** (`ckeditor5_alignment`) is a small editor-UX
enhancement. Drupal core offers text alignment in CKEditor 5 as a single dropdown
button; this module surfaces each alignment — **left, center, right, and justify** —
as its own standalone toolbar button, so editors get one-click access instead of
opening a menu first.

That is the whole module: it does not add content types, filters, or settings, and it
has no content or access-control role of its own. It simply provides extra toolbar
buttons you can add to any CKEditor 5 text format. It depends on core **CKEditor 5**
and supports Drupal 10 and 11.

You enable it per text format by dragging whichever alignment buttons you want into
the active toolbar. If you were previously using core's alignment dropdown, you can
remove that and use these individual buttons instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no standalone settings page. You add the buttons per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to add the buttons to a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the alignment buttons you want
   (**Align left**, **Align center**, **Align right**, **Justify**) from the available
   items up into the active toolbar.
3. Save the format.

Editors using that format now have direct one-click alignment buttons in the toolbar.
