# Visually Impaired Support — manual setup guide

**Visually Impaired Support** (`visually_impaired_module`) adds a toggleable "visually
impaired" (low-vision) version of your site. A small button — placed as a block — switches
the visitor into a high-contrast, large-text theme, and a companion button switches them
back to the normal site. The choice is remembered with a cookie, so it persists as the
visitor moves between pages. The feature is built to satisfy the accessibility-version
requirement of Russian legislation (GOST), but it works for any site that wants a one-click
low-vision mode.

Under the hood the module ships two blocks (a "switch on" button and a "switch off"
button) and a theme negotiator that serves your chosen theme whenever the cookie is on and
the visitor is not on an admin page — so the admin UI always stays on the normal/admin
theme. Because the switch is cookie-based and Drupal caches pages for anonymous visitors,
the module also adjusts the page cache so the normal and low-vision versions of a page are
cached separately and stay correct.

The intended partner is the separate `visually_impaired_theme` project (a ready-made
GOST-compliant low-vision theme), but you can select any enabled theme as the low-vision
version. There is no dedicated permission — the settings form uses the core *Administer
site configuration* permission — and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   the suggested companion theme.
2. [Configuration](configuration/index.md) — choose the low-vision theme, place the two
   button blocks, and understand the cookie and page-cache behavior.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Visually Impaired module**
(`/admin/config/user-interface/visually_impaired_module`), gated by the **Administer site
configuration** permission. The two switch buttons are placed through **Structure → Block
layout**.
