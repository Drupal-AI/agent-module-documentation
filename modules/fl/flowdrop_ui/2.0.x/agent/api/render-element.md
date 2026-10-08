<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `flowdrop_editor` render element

Class: `Drupal\flowdrop_ui\Element\FlowdropEditor` (`#[RenderElement('flowdrop_editor')]`). Renders the
mount container, attaches the `flowdrop_ui/editor` library, and hands per-instance settings to JS via
`drupalSettings.flowdropUi.instances`. No custom JavaScript or manual `drupalSettings` needed.

```php
$build['editor'] = [
  '#type' => 'flowdrop_editor',
  '#base_url' => '/api/flowdrop',
  '#height' => '80vh',
];
```

## Properties (from `getInfo()`)

| Property | Default | Meaning |
|---|---|---|
| `#mount` | `'app'` | `'app'` = full UI (navbar + sidebars); `'editor'` = bare canvas. Selects `mountFlowDropApp` vs `mountWorkflowEditor`. |
| `#base_url` | `''` | Base URL the client builds its endpoint map from (via `createEndpointConfig`). Empty = no endpoint config sent. |
| `#endpoint_overrides` | `[]` | Deep overrides merged into the generated endpoint config. Only sent when `#base_url` is non-empty AND this is non-empty (empty array would JSON-encode as `[]`, but the client wants an object). |
| `#height` | `'600px'` | Editor height; any CSS length. Passed as `options.height`. |
| `#mode` | `'edit'` | Interaction mode: `'edit'`, `'readonly'`, or `'locked'`. Passed as `options.mode`. |
| `#workflow` | `NULL` | Workflow to preload (render-safe array). Passed as `options.workflow` when non-null. |
| `#options` | `[]` | Any further mount option supported by the bundled library; merged first, then `mode`/`height`/`workflow` overlaid. |

Fixed behavior: `#theme_wrappers => ['container']`; the element gets a unique `data-flowdrop-editor` id
(via `Html::getUniqueId('flowdrop-editor')`), class `flowdrop-editor`, and library `flowdrop_ui/editor`.

## How settings reach JS

`preRenderFlowdropEditor()` builds `$instance = ['mount' => ..., 'options' => ...]`, adding `baseUrl` and
(conditionally) `endpointOverrides`, then writes it to
`drupalSettings.flowdropUi.instances[<unique-id>]`. The JS behavior reads that key by the element's
`data-flowdrop-editor` attribute and mounts.

Note: the element only *builds* the endpoint config from `#base_url` client-side — there is no PHP endpoint
map. The deprecated `FlowDropEndpointConfigService` is NOT used here (see [javascript.md](javascript.md)).
