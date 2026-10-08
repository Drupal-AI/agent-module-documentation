<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Layout (rest_block_layout)

rest_block_layout exposes a REST resource (`block_layout`, `GET /block-layout`) that reports the
**block layout for an arbitrary site path**. Given a `?path=` query argument, it internally
matches the route for that path, collects the blocks visible per region
(`getVisibleBlocksPerRegion()`), and returns them serialized. A custom normalizer enriches the
main-content block with the matched route name and, when the current user has *view* access to
the resolved entity, the entity itself.

This is aimed at decoupled/headless front ends that need to reproduce Drupal's block placement
(sidebars, headers, footers) for a given URL without rendering Drupal's theme.

---

## Installation & configuration

- Requires core `block`, `rest` (and typically `serialization`).
- Install with `drush en rest_block_layout`.
- Enable and configure the `block_layout` REST resource (methods/formats/auth) — e.g. via the
  REST UI module or config — and grant the `restful get block_layout` permission to the roles
  that should call it.
- Call `GET /block-layout?path=/some/path` (with your configured format/auth); the response is
  keyed by region with the visible blocks, plus route/entity metadata.
- Responses carry cache contexts (`url.query_args:path`) and block list cache tags.

---

## Use cases

- Reproduce Drupal's block layout in a React/Vue/Next.js front end.
- Fetch which blocks appear in each region for a given URL.
- Drive a decoupled site's sidebars/headers/footers from Drupal config.
- Resolve the route and entity for a path in one call.
- Keep headless navigation/promo blocks in sync with the CMS.
- Render region-based layouts without Drupal theming.
- Respect block visibility conditions on the decoupled side.
- Include the target entity payload when access allows.
- Cache block-layout responses by path query argument.
- Build a preview of block placement for editors in a SPA.
- Map Drupal regions to front-end layout slots.
- Support progressively-decoupled pages needing block data.
- Feed static-site generators with per-path block layouts.
- Centralise block placement logic in Drupal for many front ends.
- Avoid duplicating block visibility rules in the front end.
- Retrieve 404/403 page block layouts for error handling in the SPA.
