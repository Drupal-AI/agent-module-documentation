<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WBM actions — manual setup guide

**WBM actions** (`workbench_moderation_actions`) fixes a long-standing gap for sites
that use the contrib [Workbench Moderation](https://www.drupal.org/project/workbench_moderation)
module. Drupal core's built-in **Publish content** / **Unpublish content** bulk
actions do not behave correctly on moderated content, so this module removes them and
replaces them with one bulk action per moderation state. Editors can then select many
nodes on the content overview and move them all to *Published*, *Archived*, *Draft*,
*Needs Review*, or any other state you have defined — in a single operation.

It works by defining one Action plugin, `state_change`, that automatically derives a
variant for every combination of moderated entity type and moderation state (for
example "Set Content as Published," "Set Content as Archived"). These appear in the
**Action** dropdown on `/admin/content` and in any Views Bulk Operations list over a
moderated entity type. Each action respects Workbench Moderation's transition rules,
so a user only ever sees and runs the state changes they are actually allowed to make,
and non-moderated entities in a mixed selection are skipped safely.

Alongside the bulk actions, the module adds a per-row **"Set to &lt;state&gt;"** AJAX
operation link on each moderatable content row, giving editors a one-click way to
change a single item's state without leaving the list.

There is nothing to configure — no settings form, no permissions of its own. The one
operational thing to know is that the list of bulk actions is built **when the module
is installed**. If you add new moderation states later, reinstall the module (or
recreate the missing action entities) so the new states get their own bulk action.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Workbench Moderation).

## Where it lives in the admin menu

The module adds no admin page of its own. Its bulk actions appear in the **Action**
dropdown at **Content** (`/admin/content`), and its per-row **Set to &lt;state&gt;**
links appear as operations on each moderatable content row.

## How to use it

### Bulk state change

1. Go to **Content** (`/admin/content`), or any Views Bulk Operations list of
   moderated content.
2. Tick the rows you want to change.
3. In the **Action** dropdown choose **Set &lt;Entity&gt; as &lt;State&gt;** (for
   example *Set Content as Published*).
4. Click **Apply**. Each selected item is moved to that state, provided the
   transition is one you are allowed to make; invalid transitions and non-moderated
   items are skipped.

### Single-item state change

On any moderatable content row, use the **Set to &lt;state&gt;** operation link to
change just that item's state in place (it updates via AJAX).

### A note on new moderation states

Because the available bulk actions are created at install time, adding a new Workbench
Moderation state later will **not** automatically produce a matching bulk action.
Reinstall the module (uninstall, then enable again) to regenerate the full set, or
recreate the specific missing action entities. Uninstalling the module cleanly
restores core's original Publish/Unpublish actions.
