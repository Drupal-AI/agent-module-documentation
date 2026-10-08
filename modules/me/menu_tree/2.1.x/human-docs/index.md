# Menu tree — manual setup guide

**Menu tree** (`menu_tree`) replaces the "parent link" selector on the node
add/edit form with a browsable, drag‑and‑drop **tree widget**. Drupal core renders
that selector as a single long `<select>` in which the whole menu is flattened into
one list, with hierarchy hinted only by leading hyphens. On a small menu that is
fine; on a site with a hundred links across several levels it becomes genuinely
hard to use — the indentation is difficult to read, similarly named siblings blur
together, and you cannot collapse branches you do not care about.

This module swaps that flat dropdown for a visual tree that mirrors the real menu
structure, so an editor placing a page can *see* where it will sit. In this 2.x
line the widget also supports **drag‑and‑drop**: you can reorder the menu link
within any available menu directly on the node form.

It is purely a widget substitution — nothing about how menu links are stored
changes, so enabling or disabling it has no data consequences and is completely
reversible. It requires no modules beyond Drupal core, adds no routes and no
permissions of its own (access follows the node form and core's menu permissions),
and needs Drupal **10.3 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — switch the tree widget on for each
   content type that should use it.

## Where it lives in the admin menu

Menu tree adds no admin page of its own. You turn it on per content type from the
content type's **Menu settings** tab — see [Configuration](configuration/index.md).
Once enabled there, the tree widget appears automatically on that content type's
add/edit forms under the usual **Menu settings** section.
