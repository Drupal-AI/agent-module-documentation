# Inline Entity Form - View Revisions — manual setup guide

**Inline Entity Form - View Revisions** (`ief_view_revision`, distributed as the
Composer package `drupal/iefviewrevision`) is a small editorial convenience for
the **Inline Entity Form** module. For each referenced entity that IEF lists,
Drupal normally shows *Edit* and *Remove* buttons; this add‑on injects an extra
**Revisions** link beside them, so an editor can jump straight to a referenced
node's revision history without leaving the parent form.

The link points at Drupal core's node revisions page (`/node/{id}/revisions`) and
opens in a new browser tab. It works with entity reference fields whose IEF
widget lists existing entities, and — for now — it targets **node** entity types.
There is nothing to configure: enable the module and the link appears
automatically.

It's purely a convenience link and does not weaken access control. The revisions
route enforces its own permissions ("view all revisions" and node access), so a
user without revision access simply gets the standard 403 if they follow the
link — the button's presence is not itself an access grant. The module depends on
the **Inline Entity Form** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration** — it works automatically once enabled, as
described below.

## Where it lives in the admin menu

The module adds no admin page and no settings. Wherever an Inline Entity Form
widget lists referenced nodes — for example on a content type that references
other content — a **Revisions** link appears next to each item's Edit and Remove
buttons.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit content that uses an Inline Entity Form widget referencing nodes.
3. Next to each referenced item's Edit/Remove buttons, click **Revisions** to
   open that node's revision history in a new tab.
