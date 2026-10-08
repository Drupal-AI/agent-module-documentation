# Simple Access — manual setup guide

**Simple Access** (`simple_access`) is a straightforward way to make some nodes
private — viewable, editable, or deletable only by certain groups of users —
without the confusing interfaces of heavier node-access modules. It was written to
solve a specific frustration: other access modules tend to default to hiding
everything, or let you accidentally hand edit/delete rights to non-administrators.
Simple Access is deliberately conservative.

The core idea is the **access group**. An access group is built from roles — for
example a group called *Coaches* that contains the roles *Coach Level 1*, *Coach
Level 2*, and *Coach Level 3*. When you assign a node to be viewable only by
*Coaches*, only users in one of those roles can see it. Crucially, a node that is
**not** assigned to any access group stays viewable by everyone — so you can enable
this module on a site that already has content without suddenly making it all
invisible. Nodes become private only once you assign them to a group.

This is a genuine access-control module built the right way: it uses Drupal's
**node-grants system**, which enforces access at the database-query level. That
means restricted nodes are filtered out of listings and search results, not merely
hidden on their full page — avoiding the common mistake where "protected" content
still leaks through a View or search. It depends only on core's **Node** module,
provides its own permissions, and has no submodules.

When adopting it, configure your access groups and node assignments to match your
intent, and always **test** that the users who should see restricted nodes can,
and those who shouldn't can't. Note that this version is an alpha release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create access groups and assign
   nodes to them.

## Where it lives in the admin menu

The module's administration is at the `simple_access.admin` route, where you
create and manage your access groups. Individual nodes are then assigned to groups
through an *Access* section on the node add/edit form.
