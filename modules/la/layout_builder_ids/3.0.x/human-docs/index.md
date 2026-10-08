# Layout Builder Ids — manual setup guide

**Layout Builder Ids** (`layout_builder_ids`) lets content editors give a custom
HTML `id` to individual **blocks** and **sections** they place with Layout
Builder. That id becomes the real DOM `id` on the rendered element, so it can be
targeted by an anchor link (`#pricing`), a CSS selector, or a piece of
JavaScript — all without touching code or custom block classes.

This is what you reach for when building long landing pages in Layout Builder and
you want in‑page navigation: a "jump to pricing" link, a table of contents that
scrolls to each section, a "Get started" button that jumps to a hero, or deep
links straight to a specific promotional block for a marketing campaign. It's
also useful for hooking analytics/scroll‑tracking scripts or a smooth‑scroll
library onto editor‑chosen anchors, and for giving assistive technology stable
landmark ids to navigate by.

When enabled, the module adds an optional **"Block ID"** field to Layout
Builder's *Add block* / *Update block* forms and a **"Section ID"** field to the
*Configure section* form. Ids you enter are validated — each must start with a
letter, may contain only letters, numbers, hyphens and underscores, and must be
unique across the page (duplicates are rejected). The value is stored in the
layout configuration alongside the entity, so it stays consistent across
revisions. It depends only on core's **Layout Builder** module.

A tiny settings page lets you turn the Block ID and Section ID fields on or off
site‑wide (both are on by default). Beyond that toggle, everything happens right
in the Layout Builder editing experience — there is nothing per‑entity to
configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Its settings form sits at **Configuration → User interface → Layout Builder Ids**
(`/admin/config/user-interface/layout-builder-ids`), and requires the core
**Administer site configuration** permission. The form has just two checkboxes:

- **Block ID** *(on by default)* — when ticked, editors see a *Block ID* field
  when adding or configuring a block. Turning this off removes the field and also
  stops any block ids from being rendered.
- **Section ID** *(on by default)* — when ticked, editors see a *Section ID*
  field when configuring a section.

Click **Save configuration** to apply. Both toggles are global; there is no
per‑entity or per‑view‑mode setting.

## How to use it

1. Edit a layout with Layout Builder (an entity's layout, or a content type's
   default layout under *Manage display*).
2. When you **add or configure a block**, you'll see a **Block ID** field. When
   you **configure a section**, you'll see a **Section ID** field. (Each appears
   only if its matching toggle is on.)
3. Type an id — remember it must start with a letter, use only letters, numbers,
   hyphens and underscores, and be unique on the page. If it clashes with another
   id you'll get "There is already a block or section with the ID …".
4. Update the block/section and **Save** the layout. The value is rendered as the
   element's `id` attribute, so `#your-id` links, CSS `#your-id { … }`, and
   JavaScript can now target it.
