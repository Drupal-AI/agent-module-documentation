# Configure Contextual Links — manual setup guide

**Configure Contextual Links** (`configure_contextual_links`) gives you control
over Drupal's contextual links — the little "pencil" edit menus that pop up on
blocks, nodes, menus, media and other elements when you hover over them. Sometimes
those links are helpful; sometimes they get in the way, clutter the editing
experience, expose an operation you would rather nobody used (like deleting a
block), or collide with a theme's styles. This module lets you switch specific
contextual links off so the interface shows only what you want.

Unlike the old Drupal 7 "Hide Contextual Links" module, which worked block by
block, this module targets contextual link **plugins** — entries such as "Menu
edit", "Block configure", or "Media delete" — and disables the ones you pick
everywhere they appear at once. It depends on core's **Contextual** module and
provides its own permission for reaching the settings form.

One thing worth being clear about: this changes only which links are **shown**. It
does not change who is *allowed* to perform the underlying operations — contextual
links already respect Drupal's normal permissions, so hiding a link is a UI tidy‑up,
not an access‑control measure. It supports Drupal 9.4, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core Contextual dependency.
2. [Configuration](configuration/index.md) — choose which contextual links to
   disable or relabel.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface →
Configure Contextual Links**
(`/admin/config/user-interface/configure-contextual-links`).
