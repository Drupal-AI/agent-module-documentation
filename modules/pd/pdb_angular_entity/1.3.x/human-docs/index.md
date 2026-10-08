# PDB Angular Entity — manual setup guide

**PDB Angular Entity** (`pdb_angular_entity`) renders Drupal entities and components
using modern **Angular** (`@angular/elements`), built on top of the **Progressively
Decoupled Blocks (PDB)** framework. It lets you drop interactive Angular widgets
into otherwise server-rendered Drupal pages — as **placeable blocks** or as an
**entity view mode** — without rebuilding your site as a full headless SPA. This is
"progressive decoupling": Angular islands inside normal Drupal pages.

Each Angular component is compiled to a native Web Component via `@angular/elements`
(no iframe, no full SPA). Field values are resolved **server-side in PHP** and
forwarded to the component at runtime through `drupalSettings`, so your Angular code
stays clean of Drupal API knowledge. The Angular runtime loads only once per page,
and a component's own JavaScript loads only when that component actually appears.

Two things follow from how it works: any PDB component declared with
`presentation: angular` is **auto-discovered** and turned into a placeable block,
and the module adds an **"Angular Component" view mode** you can select on any
entity type's *Manage display*. Two example components (`site_info_component` and
`article_component`) ship with the module to show the pattern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside PDB,
   then enable it.

## Where it lives in the admin menu

- The module's settings form is at **`/admin/config/pdb_angular_entity/settings`**
  (gated by **Administer site configuration**).
- You use the module mainly from **Structure → Block layout** (to place the derived
  Angular component blocks) and from an entity type's **Manage display** (to select
  the Angular view mode).

## How to use it

1. Make sure **PDB** is installed and you have one or more Angular components
   available (either the bundled examples under `ng_component/`, or your own,
   declared with `presentation: angular`). Building your own component bundles
   requires Node.js and the Angular CLI (see Installation).
2. **As a block:** each discovered Angular component becomes a placeable block. Go
   to **Structure → Block layout**, place the component block in a region, and it
   renders the component's custom-element tag with its configuration passed via
   `drupalSettings`.
3. **As an entity view mode:** on an entity type's **Manage display**, choose the
   **Angular Component** display so the entity is rendered through an Angular
   component. Fields are resolved server-side and handed to the component as inputs
   (the mapping uses dot-notation such as `body:value` or `field_image:file:url`,
   with an optional token fallback).
4. Adjust the module's own options at **`/admin/config/pdb_angular_entity/settings`**
   if needed.
