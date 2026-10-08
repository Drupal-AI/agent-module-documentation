# Admin actions — manual setup guide

**Admin actions** (`admin_actions`) turns
[Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations) (VBO)
actions into **one-click buttons rendered right on an entity's page**, instead of
making editors go to `/admin/content`, tick a checkbox, and pick from the bulk
operations dropdown. Press a button on a node page and the chosen action runs
against that node.

It works by shipping a VBO-enabled view named `admin_actions`, exposed as a block,
plus a small bit of form logic that auto-selects the single row and hides the VBO
results table — leaving only the operation buttons. You place that block near the
entity pages you care about (for example `/node/*`) using Block layout. The module
supplies **no actions of its own**: you choose which actions appear by editing the
VBO field in the view, drawing on Drupal's core action plugins and contrib actions
such as [Views Bulk Edit](https://www.drupal.org/project/views_bulk_edit). Who can
see and use the buttons is governed by the view's own access settings and each
action's access check.

A bundled example submodule, **Refresh date** (`refresh_date`), adds a sample
action that resets a node's *authored on* (created) date, deferring to the node's
update-access check.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional example submodule.
2. [Configuration](configuration/index.md) — choosing actions in the view and
   placing the button block.

## Where it lives in the admin menu

The module has no settings page of its own. You configure the buttons by editing
its view at **Structure → Views → Admin actions**
(`/admin/structure/views/view/admin_actions`) and by placing its block from
**Structure → Block layout** (`/admin/structure/block`).
