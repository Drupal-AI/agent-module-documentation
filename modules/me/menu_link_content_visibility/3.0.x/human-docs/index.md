# Custom Menu Links Visibility — manual setup guide

**Custom Menu Links Visibility** (`menu_link_content_visibility`) lets you show or
hide an individual custom menu link based on the same **condition plugins** that
block visibility uses — Request Path, Node Type, User Role, Language, and so on. So
you can, for example, keep an "Admin" link visible only to administrators, show a
promotional link only on the front page, or hide a link on the content types where
it makes no sense — all without cloning menus or writing code.

You configure it per menu link. On a custom (`menu_link_content`) link's edit form
the module adds a **Visibility** section of vertical tabs, one tab per applicable
condition. Fill in one or more conditions, save, and the link appears in the
rendered menu only when **all** of them pass (AND logic). The decision is
cache-correct: each condition's cache metadata is merged in, and editing the link
re-triggers evaluation.

**One crucial caveat.** This controls **menu-link display only** — it does *not*
protect the page the link points to. A visitor who knows or guesses the URL can
still load the target unless that route or entity enforces its own access. Never
rely on a hidden menu link to secure content; pair it with real permissions or
entity access. For that reason, treat this as a navigation-curation tool, not an
access-control layer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add visibility conditions to a custom
   menu link, and the display-only caveat in full.

## Where it lives in the admin menu

There is no central settings page. You set visibility on each custom menu link from
its edit form under **Structure → Menus** (`/admin/structure/menu`) → edit the menu
→ edit a link. The **Visibility** section appears on that form. See
[Configuration](configuration/index.md).
