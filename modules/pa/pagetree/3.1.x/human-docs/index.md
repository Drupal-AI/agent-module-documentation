# Page Tree — manual setup guide

**Page Tree** (`pagetree`) lets authenticated editors browse and manage the
site's pages as a configurable **tree** built from your menu structure, rather
than as a flat content list. Each entry in the tree is a menu-linked page, and
the tree shows its current publishing status — so editors can publish,
unpublish, reorder, and copy pages directly from the hierarchy, thinking in
terms of sections and subsections instead of hunting through the content admin.

Page Tree is not a standalone menu module. It is a hierarchy/editorial layer that
sits on top of a decoupled **Frontend Publishing** stack: it depends on core
`node`, `block`, `hal`, and `menu_link_content`, plus the contrib **Pathauto**
(for page URL aliases), **REST Consumer** (`restconsumer`), and **Frontend
Publishing** (`frontendpublishing`) modules. Expect that publishing stack to be
present — this module assumes it. It also ships a **Page Tree Block** that you
place into your front-end theme so editors can reach the tree where they work.

Because it governs who can use the tree widget and manage the pages within it,
Page Tree provides its own permissions. Note that on drupal.org this project is
marked as **not covered** by the security advisory policy, so review it against
your own risk tolerance before using it on a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependency
   stack with Composer, and enable it.
2. [Configuration](configuration/index.md) — choose which menus, languages, and
   content types the tree displays, and place the Page Tree Block.

## Where it lives in the admin menu

Once enabled, Page Tree's settings live at **Configuration → Page Tree**
(`/admin/config/pagetree`), where you choose the menus, languages, and content
types the tree should display. The tree itself is surfaced through the **Page
Tree Block**, which you add to your front-end theme (see Configuration).
