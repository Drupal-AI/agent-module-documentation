<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JavaScript API, libraries & bundle surface

## Libraries (`flowdrop_ui.libraries.yml`)

- **`flowdrop_ui/editor`** — attach this. Loads `js/flowdrop-ui.js` (the Drupal integration layer) and
  depends on `core/drupal`, `core/drupalSettings`, `core/once`, and `flowdrop_ui/flowdrop`.
- **`flowdrop_ui/flowdrop`** — the bare compiled bundle `build/flowdrop/flowdrop.iife.js` + `.css` that
  defines `window.FlowDrop`. No Drupal deps. Attach directly only when replacing the integration layer.

## `Drupal.flowdropUi` (imperative API)

Defined in `js/flowdrop-ui.js`. Use when you build your own markup instead of the render element. Declare
`flowdrop_ui/editor` as a dependency of your library.

| Function | Returns | Notes |
|---|---|---|
| `mount(element, config = {})` | `Promise<app>` | No-op if already mounted (tracked in a `WeakMap`). Rejects if `window.FlowDrop` is absent. `config.mount === 'editor'` uses `mountWorkflowEditor`, else `mountFlowDropApp`. |
| `destroy(element)` | `Promise<void>` | Calls `window.FlowDrop.unmountFlowDropApp(app)`; swallows errors; no-op if not mounted. |
| `getApp(element)` | `Promise<app>` \| `undefined` | The mount promise for an element, or undefined. |

`config` shape: `{ mount, baseUrl, endpointOverrides, options }`. When `baseUrl` is set, the layer computes
`options.endpointConfig = window.FlowDrop.createEndpointConfig(baseUrl, endpointOverrides || {})`.

```javascript
Drupal.behaviors.myEditor = {
  attach(context) {
    once('my-editor', '.my-editor', context).forEach((el) => {
      Drupal.flowdropUi.mount(el, { baseUrl: '/api/flowdrop', options: { height: '80vh' } });
    });
  },
  detach(context, settings, trigger) {
    if (trigger === 'unload') {
      once.remove('my-editor', '.my-editor', context).forEach(Drupal.flowdropUi.destroy);
    }
  },
};
```

The `Drupal.behaviors.flowdropUi` behavior auto-mounts every `[data-flowdrop-editor]` element (from the
render element) on attach and destroys them on `unload` detach. Mount failures go through `Drupal.throwError`.

## `window.FlowDrop` global

The bundle also defines `window.FlowDrop`. In 2.x its supported surface is deliberately small (**30 names**,
down from 483 in 1.x) and is NOT the full `@flowdrop/flowdrop` library. Still present and stable from 1.x:
`mountFlowDropApp`, `mountWorkflowEditor`, `unmountFlowDropApp`, `WorkflowEditor`. New: `createFlowDropInstance`,
`getInstance`, `provideInstance`, `createEndpointConfig`. Prefer `Drupal.flowdropUi` — that is the layer with
a Drupal backwards-compatibility promise. Integrations needing the deep library (stores, adapters, Svelte
components) install `@flowdrop/flowdrop` from npm and use sub-module imports (`/core`, `/editor`, …).

Per-instance state is reached through the mounted app, e.g. `app.instance.workflow`, `app.instance.history`,
`app.instance.playground`, `app.instance.api`, `app.instance.nodes` — module-level singletons from 1.x are gone.

## 1.x → 2.x essentials

- Custom mount behaviors → the `flowdrop_editor` render element (no JS needed for the common case).
- Own JS → `Drupal.flowdropUi.mount`, not `window.FlowDrop.mountWorkflowEditor` directly.
- `readOnly: true` → `#mode => 'readonly'`; `lockWorkflow: true` → `#mode => 'locked'`. Old option names are
  silently ignored (a supposed-to-be read-only editor becomes editable), so grep for both.
- `initializeAllFieldTypes()` now requires the instance registry: `initializeAllFieldTypes(app.instance.fields)`.
- Passing a whole endpoint map from PHP → pass `#base_url` and let the client build the map.

## Deprecated: `FlowDropEndpointConfigService`

Service id `flowdrop_ui.endpoint_config`, class `Drupal\flowdrop_ui\Service\FlowDropEndpointConfigService`.
**Deprecated in 2.0.0, removed in 3.0.0.** Its `generateEndpointConfig($base_url)` returns the 1.x endpoint
shape, which is no longer a valid `EndpointConfig` (2.x added required `portConfig`, `categories`, `pipelines`,
`playground` groups). The render element does not use it; feeding its output to a mount option yields an editor
that cannot load its node types. Replacement: `#base_url` + `#endpoint_overrides`. CR: drupal.org/node/3617747.
