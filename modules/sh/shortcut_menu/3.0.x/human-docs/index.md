# Shortcut Menu — manual setup guide

**Shortcut Menu** (`shortcut_menu`) turns Drupal's flat shortcut sets into a
nestable menu. Core's Shortcut module stores each shortcut as a single item in a
set — which is fine for a handful of links, but stops being useful once an
editor has collected dozens. This module lets shortcuts have a **parent**, so a
set can be organised into groups and sub-items like an ordinary menu instead of
one long list.

It extends the existing shortcut entity rather than replacing it. A parent field
is added to each shortcut, and the shortcut set's *customise* screen becomes a
draggable, indentable tree — the same drag-and-drop experience you get on a menu
— so you can reorder and re-parent shortcuts by hand. The toolbar's shortcut
list then renders with that hierarchy while keeping core's caching behaviour,
and a small stylesheet tidies up the nested list in the toolbar.

Everything runs through the shortcut UI and permissions you already have: there
is no settings form, no new permissions, and no schema of its own. The core
shortcut permissions (*Administer shortcuts*, *Customize shortcut links*,
*Access shortcuts*) still apply unchanged.

Two practical notes. This is a **beta release** (`3.0.0-beta8`), so treat the
parent-field storage as still settling. And because the parent field lives on
the shortcut entity, uninstalling the module leaves that field data behind —
check your shortcut field storage before removing it from a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Shortcut Menu adds no page of its own. It works inside the existing shortcut
administration at **Configuration → User interface → Shortcuts**
(`/admin/config/user-interface/shortcut`). Open a set and click **Edit** /
**Customize** to reach the customise screen — now a draggable tree — at
`/admin/config/user-interface/shortcut/manage/{set}/customize`.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → User interface → Shortcuts** and open the set you
   want to organise.
3. On the **customise** screen, you'll now see a drag handle beside each
   shortcut. Drag a shortcut to the right to indent it under the item above,
   turning that item into its parent; drag up and down to reorder.
4. **Save** the set. The toolbar's shortcut list reflects the new nesting.

Because the module swaps in its own version of the customise form and the
toolbar's shortcut builder, another module that also overrides those would
conflict — only one such override can win.
