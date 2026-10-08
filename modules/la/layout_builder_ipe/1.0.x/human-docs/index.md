# Layout Builder IPE — manual setup guide

**Layout Builder IPE** (`layout_builder_ipe`) brings frontend **in‑place editing**
to core's Layout Builder — the kind of experience Panels IPE offered back in
Drupal 7. On the full view page of a content entity that uses Layout Builder and
allows per‑entity customization, the module shows a **Customize** link at the
bottom of the page. Click it, and the content area is replaced by the Layout
Builder interface right there, so you arrange the layout directly on the page in
its real, rendered context instead of navigating to a separate Layout tab.

It also smooths some rough edges of the core flow: the "Discard changes" and
"Revert to default" confirmations open in modal windows rather than on their own
pages, and for Page Manager pages it lets you edit variants in the frontend theme
with real frontend content previews.

Beyond the basics it adds several opt‑in behaviours: hiding the local tasks while
editing, positioning blocks at a specific place (experimental — may interfere with
other contrib that changes the "Add block" button), a smarter override of core's
EntityChangedConstraint (also experimental), non‑concurrent editing (one editing
session per user), and content locking (one editing session per content entity,
with a permission to break locks).

It is an **editing‑experience layer**: access is still governed by Layout Builder's
own permissions plus this module's. It changes the editing UI, not what a user is
allowed to edit — so grant its permissions only to people who should manage
layouts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the module's settings form and its
   permissions.

## Where it lives in the admin menu

The **Customize** link appears at the bottom of Layout Builder‑enabled entity
pages once the module is enabled and the user has the right permissions. The
module's own settings form (configuration route `layout_builder_ipe.config`) is
where you turn the optional and experimental behaviours on or off — see
[Configuration](configuration/index.md).

## How to use it

1. Make sure the entity's display uses Layout Builder and **allows each entity to
   be customized**.
2. As a user with layout‑management permission plus this module's IPE permission,
   open the full page of such an entity.
3. Click **Customize** at the bottom of the page. The content area becomes the
   Layout Builder interface; arrange sections and blocks in place, then save.

> **Compatibility note:** Layout Builder IPE works with content entities that have
> full‑page displays and with Page Manager Layout Builder variants. It also
> supports Gin Layout Builder and has been tested with Layout Builder Modal. On
> Drupal 10.3 with JavaScript aggregation there is a known core‑bug interaction —
> see the project's issue queue if you hit it.
