# Drupal Canvas — manual setup guide

**Drupal Canvas** (`canvas`) is a visual, in-browser experience builder. Content
creators and site builders compose pages and content displays by arranging reusable
components — single-directory components (SDCs), core blocks, and JavaScript "code
components" — into a stored *component tree*, then wire the components' inputs (their
"props") to Drupal data. Most of it needs no code, beyond optional JSX and CSS if you
choose to author your own code components.

Canvas deliberately inverts Drupal's usual data-first workflow. Instead of modelling
fields and then theming them, you build the layout first — an ordered tree of
component instances — and then selectively wire data into it. Props get their values
either as static values stored with the layout, or from "prop sources" that read
live data from the host entity. A clever "shape matching" step means editors are only
offered the field mappings that actually fit a given prop (for example, only image
fields appear for an image prop), so it is hard to wire something incompatible.

You can use it to build standalone **Canvas Pages** for landing and marketing
content, to design visual **content templates** that replace an entity's Manage
Display, to define reusable **page regions** (header, footer, sidebar), to save
reusable **patterns**, and to manage brand tokens (colors, fonts, logo) centrally
with a **brand kit**. The editing experience is a React single-page app with an
auto-save draft-and-publish workflow.

> **Version note.** Canvas 1.x explicitly ships **no stable public PHP or HTTP API** —
> its classes and endpoints are all internal and may change (public APIs are targeted
> for 1.1.0). Do not build integrations against its controllers or services yet. It
> also requires Drupal 11.3+ and PHP 8.3.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the plugin types and
hooks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the Drupal
   11.3 / PHP 8.3 requirements, enable the module, and pick the optional submodules.
2. [Configuration](configuration/index.md) — the admin surfaces (components, pages,
   the editor), the permissions, and what you need to supply to start building.

## Where it lives in the admin menu

- **Components library:** **Appearance → Components**
  (`/admin/appearance/component`) — the module's main configuration target.
- **Component status / audit:** `/admin/appearance/component/status` and a per-component
  audit page.
- **Canvas Pages:** **Content → Pages** (`/admin/content/pages`).
- **The builder itself:** `/canvas` and `/canvas/editor/{entity_type}/{entity}`.

Access is split across several permissions (see [Configuration](configuration/index.md)).

## How to use it

1. Install and enable Canvas (plus core Media and Media Library for image support).
2. Supply a component system — build your own SDCs or code components, or start from
   an existing set such as the Mercury theme or the Nebula code-component scaffold.
3. Enable the components you want in **Appearance → Components**.
4. Create a Canvas Page from **Content → Pages → Add**, or open an existing entity in
   the editor, and compose your layout by dragging in components and wiring their
   props to data.
5. Use the auto-save draft workflow, then publish when ready (gated by the "publish
   auto-saves" permission).
