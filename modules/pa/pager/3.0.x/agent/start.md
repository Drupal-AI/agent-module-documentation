<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pager (pager) — agent index

Contrib **block** that renders **previous/next navigation between individual nodes** — thumbnail,
title and prev/next label. This is **NOT** core's numbered pager and **NOT** a Views pager plugin.
Installed release **3.0.1**, core `^9.3 || ^10 || ^11`, package `Other`.

## What it actually is
- Provides exactly one plugin: a **Block** — `id: pager`, admin label "Pager Block"
  (`src/Plugin/Block/PagerBlock.php`).
- On a node route it queries neighbouring **published** nodes ordered **strictly by the `created`
  timestamp** (chronological), limited to selected content types and selected taxonomy terms.
- Renders each neighbour via an image field + image style thumbnail, the node title, and a
  configurable label, linking to the node's canonical URL.
- Two shipped themes/templates: `pager_block` (centred) and `pager_wings` (fixed slide-out side
  tabs). CSS library `pager/drupal.pager-links` (`css/pager.css`).
- `PagerStorage` service (`pager.storage`) holds the raw SQL (parameterised) against `node`,
  `node_field_data`, `taxonomy_index`, `taxonomy_term_field_data`, and `config`.

## Correcting common wrong assumptions
- The sequence is ordered ONLY by node `created` time. There is **no** weight field, menu order,
  book order, or custom sort — a wider design is not implied by the dependency list.
- There is **no admin/settings page**. `.info.yml` declares `configure: pager.admin` but the module
  defines **no routing**, so that link is dead. All configuration is on the **block placement form**.
- 3.0.1 ships **no sub-modules** and **no Views integration**. Views-integration sub-modules
  ("Pager Views", "Pager Views Example") exist only on the 3.1.0-beta line and are absent here.
- The `administer pager` permission is declared but **unused** (no route consumes it). Placing the
  block uses core's `administer blocks`.
- No config schema is shipped (`config/schema` absent).

## Visibility gate (why the block may render nothing)
`build()` returns `[]` unless: (1) the route has a `node` parameter, (2) the node's type is in the
selected types, and (3) the node is tagged with one of the selected terms (`getTid()` != 0), and
at least one neighbour is found. The block also has `#cache max-age 0` (uncacheable).

## Dependencies
`block`, `filter`, `node`, `system`, `taxonomy`, `text`, `user` (all Drupal core). Requires the
`image` module at runtime (uses `Drupal\image\Entity\ImageStyle` / `image.factory`) even though it
is not listed in `.info.yml` — image styles must exist for the block form to be usable.

## Where to look next
- `blocks/pager-block.md` — full per-block configuration reference and build/query mechanism.
- `theming/templates.md` — the two themes, their Twig templates, and the CSS library.
- `../usage.md` — prose overview and use cases.
