# Lock Layout Builder — manual setup guide

**Lock Layout Builder** (`lock_layout_builder`) bridges Drupal's core **Layout
Builder** with the contrib **Content Lock** module so that two editors can't
clobber each other's work on the same layout. When one user is editing an entity's
layout, Content Lock holds a lock on that entity — and this module makes Layout
Builder respect it: only the user who currently holds the lock may add, configure,
move, or remove sections and blocks. Anyone else who opens that layout is stopped
from making changes until the lock is released.

The locking applies to the full set of Layout Builder mutation operations — add,
configure, and remove sections; add, configure, move (including drag-and-drop and
cross-region moves), and remove components, including inline blocks. It's a natural
fit for high-traffic landing pages and shared displays where several people manage
the layout and lost updates would be painful.

The best part of the setup is that there **isn't any**. Once the module is enabled,
it wires itself into the Layout Builder routes automatically — there are no
settings to configure, no permissions of its own to grant, and nothing to switch
on. The enforcement is fail-safe: to operate on a layout you must be the lock
holder, and where Layout Builder is used without a lockable entity in context the
module simply defers to Layout Builder's own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Layout Builder / Content Lock dependencies.

There is **no configuration page** for this module — it has no settings form and
defines no permissions of its own. Once enabled, it just works.

## Where it lives in the admin menu

Lock Layout Builder adds no admin page. Its behavior appears in the **Layout**
tab of any entity that uses Layout Builder: a second editor opening a layout that a
colleague already holds the lock on will be prevented from changing it. Locking
itself is governed by the **Content Lock** module's own configuration
(`/admin/config/content/content_lock`), where you choose which entity types are
lockable.

## How to use it

1. Enable Layout Builder for a content type or display, and configure **Content
   Lock** to lock the entity types you care about.
2. Enable this module — no further setup needed.
3. When someone edits an entity's layout, they hold the Content Lock; other users
   are blocked from mutating that layout until the lock is broken or released.
