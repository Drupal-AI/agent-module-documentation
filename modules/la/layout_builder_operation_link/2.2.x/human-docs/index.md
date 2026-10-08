# Layout Builder Operation Link — manual setup guide

**Layout Builder Operation Link** (`layout_builder_operation_link`) adds a
**Layout** link to the operations dropbutton of any entity whose bundle has
Layout Builder enabled *with overrides*. In other words, on a listing like
`/admin/content`, editors get a one‑click "Layout" action right in the same
dropdown as *Edit* and *Delete*, taking them straight to that item's Layout
Builder page — no need to open the edit form and hunt for the Layout tab first.

Because it hooks into Drupal's generic entity‑operation system, the link appears
for **any** entity type that shows an operations dropbutton: nodes on
`/admin/content`, taxonomy terms on the vocabulary overview, users, media, and
custom admin Views that render operations. The link is access‑gated — it only
shows to users who can actually edit that entity's layout — so it doubles as a
subtle signal of which bundles have per‑entity overrides and who is allowed to
use them.

The module has **no configuration, settings form, permissions, or Drush commands**
of its own. The only "setup" is turning on Layout Builder overrides for a bundle;
after that, enable this module and the link appears wherever it applies. When
layouts are translatable (for example with the Layout Builder Asymmetric
Translation module), it targets the layout of the specific translation being
viewed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no admin page. The Layout link itself shows up in the operations
dropbutton on entity listings — most visibly at **Content** (`/admin/content`).

## How to use it

There is nothing to configure in this module. The link appears for an entity only
when **all** of the following are true, checked per entity:

1. The entity's bundle has **Layout Builder enabled** on its default view
   display, and
2. **overrides are allowed** ("Allow each content item to have its layout
   customized"), and
3. the current user has permission to edit that entity's layout.

If overrides are off or the user lacks the permission, the link is simply absent —
no error.

So the actual setup is enabling Layout Builder overrides on a bundle. In the UI:
**Structure → Content types → (type) → Manage display**, check **Use Layout
Builder** and **Allow each content item to have its layout customized**, then
**Save**. Once that's done and this module is enabled, the **Layout** link (which
sorts after Edit/Delete) points to `/<entity-path>/layout`, for example
`/node/123/layout`.
