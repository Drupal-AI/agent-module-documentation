# Forum — manual setup guide

**Forum** (`forum`) provides classic threaded discussion boards for a Drupal site
— a hierarchy of containers and forums in which users post topics and reply with
comments. It was once part of Drupal core and is now maintained as a contributed
module.

Enabling the module sets up a complete message-board experience out of the box. It
creates a **Forums** taxonomy vocabulary (the board structure lives here as terms),
a **Forum topic** content type for the discussions themselves, a term-reference
field that ties each topic to exactly one forum, and a dedicated comment type for
replies. Board admins build the structure at **Structure → Forums** by adding
*containers* (grouping-only headings such as "Support" or "General") and *forums*
(the leaf boards that actually hold topics), and dragging them into a tree.
Visitors browse the index at `/forum`, drill into a forum, and read topics with
forum-aware breadcrumbs.

Global behaviour — how many topics show per page, the reply count at which a
thread becomes "hot", the default sort order, and how many items the two forum
blocks list — lives on a settings form. The module also ships two blocks, **Active
forum topics** and **New forum topics**, integrates with core's History module to
track read/unread topics per user, and provides Views integration and services for
querying the board from code.

Because the board is built on core's node, taxonomy, comment, and history
subsystems, the module depends on all of them (plus Options), and core installs
them for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — build the container/forum tree, the
   global settings, the two blocks, and the permissions.

## Where it lives in the admin menu

The board structure is managed at **Structure → Forums**
(`/admin/structure/forum`), and the global settings at **Structure → Forums →
Settings** (`/admin/structure/forum/settings`). The public board is at `/forum`.

## How to use it

1. Enable the module — the vocabulary, content type, and comment type are created
   automatically.
2. At **Structure → Forums**, add containers and forums and arrange them into a
   tree.
3. Grant the posting/reply permissions to your member roles (see
   [Configuration](configuration/index.md)).
4. Optionally place the *Active forum topics* and *New forum topics* blocks in your
   sidebar. Members can then start topics and reply from `/forum`.
