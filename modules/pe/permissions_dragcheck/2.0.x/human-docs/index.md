# Permissions DragCheck — manual setup guide

**Permissions DragCheck** (`permissions_dragcheck`) lets you tick a whole run of
permission checkboxes by clicking and dragging across them, instead of clicking
each one individually. On a site with a hundred modules, the permissions page is
a grid of several thousand checkboxes, and setting up a role means clicking a
great many of them — so drag-to-check is the kind of small interaction
improvement that saves a genuinely irritating amount of time on a task
administrators do at the start of every project.

It is a lightweight alternative to the Fast Permissions Administration (FPA)
module, and it works by wiring up the excellent
[Drag Check](https://github.com/scarlac/drag-check-js) JavaScript library into
the core permissions matrix. It is **JavaScript only** — no permissions, no
routes, no configuration — and it changes nothing about what the permissions
page *does*, only how quickly boxes can be ticked.

That speed is worth a moment's thought, because the permissions page is the one
screen where clicking quickly is most costly. Granting a permission by accident
is not visible afterwards — an accidentally-ticked box looks identical to a
deliberate one — and permissions are your site's access control. The remedy is
not to avoid the module but to change your review habit: after a bulk change,
read back what the role now holds rather than trusting the gesture, and pay
attention to anything marked `restrict access`. It pairs well with the habit of
exporting configuration, so a permissions change shows up in a diff where it can
be reviewed like any other change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JavaScript
   library, then enable it.

There is **no settings form** — the drag behaviour is active on the permissions
page as soon as the module and its library are in place.

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Click on a checkbox and, holding the mouse button, drag up or down across the
   neighbouring checkboxes — they all toggle together in one gesture.
3. **Review the role afterwards.** Read back the permissions the role now holds,
   watching for anything marked `restrict access` that may have been caught by a
   drag, and export configuration so the change lands in a reviewable diff.

> **Tip:** consider pairing it with the
> [Permissions Filtered by Module (PFM)](https://www.drupal.org/project/pfm)
> module, which adds a lightweight filter-by-module control to the permissions
> overview.
