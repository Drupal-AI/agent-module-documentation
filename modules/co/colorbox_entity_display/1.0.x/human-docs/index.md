# Colorbox Entity Display — manual setup guide

**Colorbox Entity Display** (`colorbox_entity_display`) lets you open a full **content
entity inside a Colorbox lightbox** — a node, media item, paragraphs library item, or
other entity — without a page load. When a visitor clicks a specially marked link, the
module loads the entity's rendered markup (plus the CSS/JS it needs to look right) over
an AJAX JSON endpoint and displays it in the Colorbox modal.

It builds on the **Colorbox** module (and its Colorbox JavaScript library), which is a
required dependency. There is no dedicated settings form; you make an entity appear in
the lightbox by wiring up a link with the right class and target path. Optionally, if
you define a **`colorbox` view mode** on an entity type, the module uses it when
rendering that entity in the lightbox; otherwise it falls back to the entity's `full`
view mode.

A reassuring detail on the security side: before returning any markup, the module
re-checks **entity `view` access** for the requesting user, so unpublished or private
entities are protected — the internal path-resolution step is only used to find the
entity, never to grant access to it. Note that in this version only local (file) CSS/JS
assets are emitted in the lightbox; external/CDN library assets are not.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Colorbox.

There is **no dedicated settings form** — you wire up trigger links yourself,
described in "How to use it" below.

## How to use it

1. (Optional) Add a **`colorbox` view mode** to the entity types you want to display,
   and configure its **Manage display** to show just what should appear in the
   lightbox. If you skip this, the entity's **`full`** view mode is used.
2. Create a link that points at the entity-load endpoint and carries the
   **`colorbox-display`** class. The endpoint is
   `/colorbox-entity-display/entity-load/{entity_path}`, where `entity_path` is the
   entity's alias or system path. For example:

   ```html
   <a class="colorbox-display" href="/colorbox-entity-display/entity-load/node/123">
     See my content in a colorbox!
   </a>
   ```
3. When a visitor clicks the link, the module renders the entity (after checking they
   have `view` access) and Colorbox opens it in the lightbox.

The load route requires the **access content** permission, and per-entity `view`
access is always enforced, so visitors only ever see entities they are allowed to see.
