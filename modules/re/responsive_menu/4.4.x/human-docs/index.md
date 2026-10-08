# Responsive menu — manual setup guide

**Responsive menu** (`responsive_menu`) turns any Drupal menu into a
mobile-friendly navigation system. On small screens it shows a JavaScript
off-canvas "hamburger" menu that slides in over the page (using the *mmenu*
library), with drill-down support for deep, multi-level menus. On wider screens
it renders the same menu as a horizontal drop-down/flyout bar. A theme breakpoint
you choose decides where the switch between the two happens.

The module ships two blocks — a **mobile icon** (the burger toggle) and a
**horizontal menu** block — plus a single settings form. From that form you pick
which menu becomes the horizontal menu and which menu(s) feed the off-canvas
panel (you can merge several menus, for example a main menu plus a utility menu),
then choose the breakpoint at which the layout flips. The off-canvas panel is
themeable (light/dark/black/white), can slide in from the left, right, or based
on language direction, can dim the page behind it, and can respond to a
swipe/drag gesture.

Two things are important to know before you start. First, the off-canvas menu
**will not render** until you install the mmenu JavaScript library into
`/libraries/mmenu`. Second, config alone shows nothing on the page until you
**place the two blocks** in your theme's regions. Both steps are covered in the
installation and configuration guides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the mmenu
   library, and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus placing the two blocks.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Responsive menu**
(`/admin/config/user-interface/responsive-menu`). The two blocks are placed from
**Structure → Block layout**.

## How to use it

1. Install the mmenu library (see [Installation](installation/index.md)).
2. Open the settings form and choose your horizontal menu, off-canvas menu(s),
   breakpoint, and panel style.
3. Place the **Responsive menu mobile icon** block and the **Horizontal menu**
   block in your theme regions from Block layout.
4. Resize the browser past your chosen breakpoint to see it switch between the
   horizontal bar and the off-canvas hamburger menu.
