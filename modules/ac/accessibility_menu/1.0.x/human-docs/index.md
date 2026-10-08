# Accessibility menu — manual setup guide

**Accessibility menu** (`accessibility_menu`) adds the floating accessibility
toolbar you see on many public-sector sites — a widget offering **text resizing**,
**contrast adjustment**, grayscale/inverted display and similar visual
accommodations, plus a reset. You place it as a block, choose which accommodations
it offers, and visitors use it to adapt the page's appearance to their needs.

Under the hood it is mostly front-end work with a thin Drupal layer: the widget's
styles (desktop and mobile) and JavaScript ship with the module, a block plugin
puts it on the page, and a settings form controls what it offers. The interface
strings are translatable through drupal.org's localisation server, and it has no
dependencies beyond Drupal core (it runs on Drupal 9.3, 10 and 11).

It is worth being clear about what a widget like this does and does not achieve. It
can genuinely help visitors who need larger text or higher contrast and do not know
how to change their browser or operating-system settings, and public-sector
procurement often asks for one. It does **not** make an inaccessible site
accessible — semantic markup, keyboard operability, focus management and the
design's own colour contrast are what WCAG actually measures, and an overlay cannot
retrofit them. Some accessibility practitioners actively advise against overlays.
Treat it as a convenience for visitors offered *alongside* real accessibility work,
never as a substitute for it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form and placing the
   widget.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Accessibility menu**
(`/admin/config/development/accessibility-menu`), behind the **Administer site
configuration** permission. The widget itself is placed as a block at
**Structure → Block layout** (`/admin/structure/block`).
