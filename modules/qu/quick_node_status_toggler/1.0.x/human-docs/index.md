# Quick Node Status Toggler — manual setup guide

**Quick Node Status Toggler** (`quick_node_status_toggler`) adds a modern,
AJAX‑powered **toggle switch** to Drupal's content administration list, so you can
publish or unpublish a piece of content with a single click — no need to open the
node, and no page reload. It is a small quality‑of‑life boost for anyone who spends
time managing content at `/admin/content`.

The switch is animated and colour‑coded so the published/unpublished state is
obvious, and updates happen instantly via the Fetch API (built with vanilla
JavaScript, so there's no legacy‑library overhead). On install the module is
"plug‑and‑play": it automatically adds a **Quick Status Toggle** column to the
default *Content* view, so the toggles appear the next time you visit
`/admin/content`.

It is careful about access. The toggle route requires the **Administer nodes**
permission, and before it changes a node's status it checks that you actually have
*update* access to that specific node — so you can never toggle content you aren't
allowed to edit. All AJAX operations are CSRF‑protected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — it wires the toggle into the default
Content view automatically on install.

## How to use it

Enable the module and visit **Content** (`/admin/content`). You'll see a toggle
switch in each row; click one to publish or unpublish that item instantly. If you
manage content through a **custom view** instead of the default one, add the **Quick
Status Toggle** field to that view yourself via the Views UI. Access is governed by
core: users need **Administer nodes**, and even then can only toggle nodes they have
permission to update.
