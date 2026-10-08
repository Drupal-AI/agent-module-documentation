# Show Node Aliases — manual setup guide

**Show Node Aliases** (`show_node_aliases`) lists **every** URL alias (path) pointing
at a node, right on that node's edit form. Core's own Path field only ever shows one
alias per node, but a node can accumulate several — from Pathauto, from translations,
or from aliases added by hand. This module surfaces the full list in an "Existing
Aliases" section on the edit screen so you can see them all in one place, together
with each alias's language.

For users who hold core's **Administer URL aliases** permission, each listed alias
also gets inline **Edit** and **Delete** links that deep-link straight into core's
alias edit/delete pages and bring you back to the node afterward. That makes it easy
to fix a wrong alias, clean up stale ones left over after a title or Pathauto-pattern
change, or troubleshoot "why does this node answer on two URLs" — all without
leaving the content you're editing. Users without that permission still see the read-
only list, just without the Edit/Delete column.

The module only **reads** aliases from core's `path_alias` storage and deep-links to
core's tools; it never creates or changes aliases itself — creating, editing and
deleting all happen through core's normal path UI. It has no settings form, no
configuration, and no permission of its own (it reuses core's *Administer URL
aliases*). Its one dependency is core's **Path** module. If a node has no aliases,
the section simply doesn't appear.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no admin page. The feature appears on the **node edit form** itself, in an
**Existing Aliases** section attached to the URL alias (Path) field. The Edit/Delete
links point into core's alias tools under **Configuration → Search and metadata →
URL aliases** (`/admin/config/search/path`).

## How to use it

1. Enable the module (and make sure core's **Path** module is on — it is a
   dependency).
2. Edit a node that has one or more URL aliases. Below the Path field you'll see an
   **Existing Aliases** table listing each alias and its language.
3. If your account has the **Administer URL aliases** permission, each row also
   shows **Edit** and **Delete** links. Clicking one takes you to core's alias
   edit or delete confirmation, and returns you to the node edit form when you're
   done.

To let editors manage aliases from here, grant them **Administer URL aliases** at
**People → Permissions** (`/admin/people/permissions`). Without it they can still
see the list but not the Edit/Delete actions.
