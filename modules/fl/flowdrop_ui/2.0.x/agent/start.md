<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop UI — agent index

Provides the **FlowDrop visual workflow editor** for Drupal (bundled `@flowdrop/flowdrop` 2.x Svelte app).
Version **2.0.x**. Core `^11`. Developer/UI library — no admin UI, routes, permissions, config, or Drush.

Two integration points:

- [Render element `flowdrop_editor`](api/render-element.md) — the recommended way: render an editor with
  no custom JS. Properties, defaults, PHP example.
- [JavaScript API & bundle surface](api/javascript.md) — `Drupal.flowdropUi.mount/destroy/getApp` for
  imperative control, the `window.FlowDrop` global, mount options, library names, deprecated service.

2.x is a breaking rewrite of 1.x: `window.FlowDrop` shrank 483 → 30 names, state is per-instance, and the
`readOnly`/`lockWorkflow` options collapsed into `#mode`. See the JS doc for the migration essentials.
