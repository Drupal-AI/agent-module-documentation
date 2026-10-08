<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop UI provides the FlowDrop visual workflow editor as a Drupal render element and JS mount API.

---

FlowDrop UI wraps the bundled `@flowdrop/flowdrop` 2.x Svelte app (`window.FlowDrop`) for Drupal. The
main integration point is the `flowdrop_editor` render element: give it a `#base_url` and it renders the
container, attaches the `flowdrop_ui/editor` library, and passes per-instance settings to JavaScript — no
custom JS or `drupalSettings` plumbing needed. The bundled JS behavior (`Drupal.behaviors.flowdropUi`)
mounts each editor and exposes an imperative API (`Drupal.flowdropUi.mount/destroy/getApp`) for modules
that build their own markup. In 2.x the endpoint map is built client-side by `createEndpointConfig()` from
the base URL, so upstream endpoint changes need no PHP change. State is per-instance, so multiple editors
can share a page. The module has no admin UI, routes, permissions, or config; it is a developer/UI library
depended on by other FlowDrop modules (flowdrop, flowdrop_workflow, flowdrop_runner).

---

- Embed a FlowDrop workflow editor in a route or block with the `flowdrop_editor` render element.
- Point the editor at an API by setting `#base_url`.
- Render the full app UI (`#mount => 'app'`) or the bare canvas (`#mount => 'editor'`).
- Set editor height with `#height` (any CSS length).
- Open an editor read-only with `#mode => 'readonly'`.
- Lock a workflow with `#mode => 'locked'`.
- Preload a workflow into the editor via `#workflow`.
- Override specific generated endpoints with `#endpoint_overrides`.
- Pass extra library mount options via `#options`.
- Mount an editor imperatively into your own markup with `Drupal.flowdropUi.mount(el, config)`.
- Tear an editor down with `Drupal.flowdropUi.destroy(el)`.
- Reach a running mounted app with `Drupal.flowdropUi.getApp(el)`.
- Reach per-instance state (workflow, history, playground, api) via the mounted app object.
- Run multiple independent editors on one page (per-instance state).
- Attach the bare compiled bundle (`flowdrop_ui/flowdrop`) when replacing the Drupal integration layer.
- Serve as the UI base library for FlowDrop-based tools.
- Migrate a 1.x integration to the render element (drop custom mount behaviors).
- Replace removed 1.x `readOnly`/`lockWorkflow` options with `#mode`.
- Persist and clear per-instance workflow drafts in localStorage.
- Depend on it from other FlowDrop modules as the editor front end.
