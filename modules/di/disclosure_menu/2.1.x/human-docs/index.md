# Disclosure Menu — manual setup guide

**Disclosure Menu** (`disclosure_menu`) is an accessible alternative to Drupal's core
menu block. Instead of forcing keyboard and screen-reader users to tab through every
link to reach a submenu, it renders dedicated **disclosure buttons** — with proper ARIA
labels and `aria-expanded` state — that open and close each submenu. It's a solid base
for accessible dropdown navigation, whether horizontal, vertical, or a multi-level
mega-menu.

It ships a single **block** that extends core's menu block (using the same
one-block-per-menu deriver), so you place it exactly like the core menu block — one
instance per menu, via the Block layout UI. All configuration is **per block instance**;
there's no global settings page. On top of the core menu depth/level options, each block
adds settings for submenu toggles (levels, chevron icon, optional token-driven labels), a
full-menu toggle button, JavaScript behaviour (including optional hover navigation with
show/hide delays), and bundled horizontal/vertical CSS.

The module requires two contrib modules: **Token** (for the templated button labels) and
**Twig Tweak**. It defines no permissions and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the Token
   and Twig Tweak dependencies) and enable the module.
2. [Configuration](configuration/index.md) — placing the block and its per-instance
   settings, field by field.

## Where it lives in the admin menu

There's no central settings page. You place and configure a Disclosure Menu block at
**Structure → Block layout** (`/admin/structure/block`) — click **Place block** and
choose the "Disclosure menu" entry for the menu you want (there's one per menu). All
options live on that block's configuration form.
