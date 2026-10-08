# Breadcrumb Menu — manual setup guide

**Breadcrumb Menu** (`breadcrumb_menu`) builds the breadcrumb trail from your
**menu link titles** rather than from page titles. Drupal's default breadcrumb is
derived from the path and uses each page's own title — which is often wrong in a
specific, annoying way. A page titled *"Applying for a residents' parking permit
in the borough"* appears in the menu as *"Parking permits"*, and the breadcrumb
should read the short label the editor chose for navigation, not the long one
written for the page. Long titles also break the visual line of a breadcrumb and
push it onto two rows on mobile.

This module replaces the breadcrumb builder: it resolves the trail through the
menu and uses the menu link titles where a link exists, falling back to the page
title where none does — so pages outside the menu still get a trail. The result
is a breadcrumb that reads the way the navigation reads and matches your
information architecture.

It has no dependencies beyond core, supports a wide range of core versions
(`^8 || ^9 || ^10 || ^11`), and gates its behaviour behind its own
`administer breadcrumb_menu` permission so breadcrumb configuration can be
delegated without granting full site-configuration rights.

One practical caveat: because it registers a breadcrumb builder, it competes with
any other breadcrumb module **by priority**. Running two breadcrumb modules at
once is the usual cause of "my breadcrumb settings do nothing" — check what else
is registered before debugging this one.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## Where it lives in the admin menu

Breadcrumb Menu has a small settings form at **Configuration → System →
Breadcrumb Menu** (`/admin/config/system/breadcrumb-menu`), reachable by users
with the module's own **Administer breadcrumb_menu** permission rather than the
broad *Administer site configuration* permission.

## How to use it

Enable the module and its menu-driven breadcrumbs take effect. Where a page has a
menu link, the trail uses the menu link titles; where a page is not in any menu,
it falls back to the page title. Use the settings form to adjust the behaviour to
your site. If your breadcrumbs do not change after enabling, check whether another
breadcrumb module is also registered — the one with the higher priority wins, so
you may need to disable the other or adjust priorities.
