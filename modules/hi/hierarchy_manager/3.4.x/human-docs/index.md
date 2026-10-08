# Hierarchy Manager — manual setup guide

**Hierarchy Manager** (`hierarchy_manager`) replaces Drupal core's
draggable‑table UI for taxonomy terms and menu links with a scalable, filterable,
drag‑and‑drop tree (powered by jsTree by default). Core's draggable table simply
can't cope with a large hierarchy on a single page; Hierarchy Manager renders the
hierarchy as a JavaScript tree that loads and saves its data over JSON endpoints,
so you can comfortably manage vocabularies with thousands of terms.

With it enabled, you drag a node to reorder it or drop it under a different parent
to re‑parent it, and the change is saved in the background. It also gives you a
search/filter box to find a term or link quickly in a deep tree, and an optional
confirmation step before a drag is committed. Every drag issues an authenticated,
CSRF‑protected request that re‑checks per‑term and per‑link access before saving —
so the tree doesn't loosen Drupal's normal permissions.

Under the hood it's built around a small **plugin architecture**. It ships two
"setup" plugins (one for taxonomy, one for menus) that decide which forms get
taken over, and one "display" plugin (jsTree) that draws the tree. Because these
are pluggable, other modules can add hierarchy management for any entity type, or
swap jsTree for a different front‑end library, without touching the rest.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (optionally) self‑host the jsTree library.
2. [Configuration](configuration/index.md) — create a display profile, enable a
   setup plugin, and bind it to your vocabularies or menus.

## Where it lives in the admin menu

Two places:

- **Display profiles** at **Structure → HM Display Profile**
  (`/admin/structure/hm_display_profile`) — reusable tree‑rendering presets.
- **Main settings** at **Configuration → User interface → Hierarchy Manager**
  (`/admin/config/user-interface/hierarchy_manager/config`) — where you enable
  setup plugins and bind them to profiles and bundles.

Both require the core **Administer site configuration** permission. Hierarchy
Manager defines no permissions of its own — it reuses core's
`administer taxonomy` / `edit terms in <vid>` and `administer menu`.

## How to use it

The setup is a quick two‑step process (covered in detail in
[Configuration](configuration/index.md)): create a display profile choosing a
display plugin, then enable the taxonomy and/or menu setup plugin and bind each to
that profile and the specific vocabularies or menus you want. Once bound, the
taxonomy term overview page and the menu edit form are replaced by the interactive
tree — the underlying term/menu‑link edit forms stay exactly as they were.
