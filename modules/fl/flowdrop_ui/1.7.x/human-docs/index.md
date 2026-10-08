# FlowDrop UI (1.7.x) — manual setup guide

**FlowDrop UI** (`flowdrop_ui`) provides the user interface for **FlowDrop** — a
visual workflow editor built with Svelte. It is a supporting library module in the
FlowDrop ecosystem: it wraps the upstream `@d34dman/flowdrop` JavaScript library as a
self‑contained (IIFE) bundle and exposes it to Drupal, giving other FlowDrop modules
the canvas, nodes, and connections they build their tools on.

On its own this module renders no pages and adds no admin screens — it is a
**developer/UI foundation**, not an end‑user feature. You use it by attaching its
library and mounting the editor into a container from your own module's JavaScript.

> **Which version is this?** This is the **1.7.x** line. It exposes a global
> `window.FlowDrop` object with `mountFlowDropApp()` and `mountWorkflowEditor()`
> functions that you call from a Drupal behavior, passing an `endpointConfig`,
> `workflow`, and `nodes`. The later **2.0.x** line is a breaking rewrite that replaces
> this manual mounting with a `flowdrop_editor` render element and a much smaller
> `Drupal.flowdropUi` mount API — if you are integrating for the first time on Drupal
> 11, prefer 2.0.x. This 1.7.x page documents the mount‑function approach that existing
> integrations use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it is a UI library with no admin
UI, routes, or permissions. Integration happens in code, described below.

## How developers use it

1. Attach the editor library from a render array or template:

   ```php
   $build['#attached']['library'][] = 'flowdrop_ui/editor';
   ```

2. Mount the editor from a Drupal behavior using the global `window.FlowDrop` object:

   ```javascript
   Drupal.behaviors.flowdropWorkflowEditor = {
     attach: function (context, settings) {
       const container = context.querySelector('.flowdrop-workflow-editor');
       if (container && window.FlowDrop) {
         window.FlowDrop.mountWorkflowEditor(container, {
           endpointConfig: settings.flowdrop.endpointConfig,
           workflow: settings.flowdrop.workflow,
           nodes: settings.flowdrop.nodes,
         });
       }
     },
   };
   ```

   Use `window.FlowDrop.mountFlowDropApp(container, options)` to mount the full app, or
   `mountWorkflowEditor(container, options)` for just the editor component.

3. Generate the API endpoint configuration server‑side with the
   `flowdrop_ui.endpoint_config` service
   (`FlowDropEndpointConfigService::generateEndpointConfig('/api/flowdrop')`), and pass
   options such as `baseUrl`, `endpoints`, `timeout`, and a `retry` policy.

If you are building on FlowDrop rather than authoring it, you normally get this module
automatically as a dependency of the FlowDrop module you install.
