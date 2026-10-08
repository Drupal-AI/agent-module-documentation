# PDB Vue js — manual setup guide

**PDB Vue js** (`pdb_vue`) lets you place **Vue.js** components on your site as
ordinary Drupal blocks, using the **Progressively Decoupled Blocks** (PDB)
framework. Progressive decoupling is the middle path between a fully separate
front‑end application and a purely server‑rendered site: Drupal keeps rendering
the page, its routing, and its block layout, while JavaScript takes over just the
regions you choose — an interactive dashboard, a live basket, a small widget. This
module adds Vue as one of the supported frameworks for that mechanism.

Because a "PDB block" is just a normal Drupal block, you place it through **Block
layout** like any other block, and it keeps everything Drupal gives you:
contextual links, block visibility rules, caching, and page assembly. You do not
give any of that up the way full decoupling would.

The module is really meant for developers building Vue components, and its best
documentation is the **eleven example submodules** it ships (see Installation).
They cover Vue 2 and Vue 3, two build toolchains (Vite and webpack), shared state
between two separately placed blocks (Pinia), and running a small single‑page app
inside a block. Note that **Vue 2 reached end of life at the end of 2023**, so new
work should start from the `vue3_*` examples; the Vue 2 ones are there to help
maintain existing components. Vue 3 is the default version on install, and you can
choose between Vue 2 and Vue 3 on the module's settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the PDB base
   module with Composer, enable it, and turn on whichever example submodules you
   want to learn from.

There is no field‑by‑field settings page worth a chapter of its own — the module
adds a small Vue settings form (Vue 2 vs Vue 3) at
**Configuration → Web services → Decoupled Blocks (Vue)**
(`/admin/config/services/pdb-vue`), behind the *administer decoupled vue blocks*
permission. The real work happens in your Vue component code and in placing the
resulting blocks, described below.

## Where it lives in the admin menu

- The Vue settings form (choose Vue 2 or Vue 3) sits at
  **Configuration → Web services → Decoupled Blocks (Vue)**
  (`/admin/config/services/pdb-vue`).
- The blocks your components provide are placed from **Structure → Block layout**
  (`/admin/structure/block`), exactly like any other block.

## How to use it

1. Enable `pdb_vue` (it pulls in the PDB base module). To learn the pattern,
   enable one of the example submodules too — the **Vue 3** examples are the right
   starting point.
2. Look at the enabled example under `modules/contrib/pdb_vue/modules/…` to see how
   a Vue component is declared and registered as a PDB block.
3. Go to **Structure → Block layout** and place the example's block into a region,
   just like any other block. Save the layout and view the page — the Vue
   component renders in that region while Drupal renders the rest.
4. Build your own component by following the example's structure. The
   `vue3_pinia_a` + `vue3_pinia_b` pair is the most instructive when you need two
   independently placed blocks to share state.
