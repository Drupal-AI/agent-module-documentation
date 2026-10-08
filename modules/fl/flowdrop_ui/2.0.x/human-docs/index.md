# FlowDrop UI (2.0.x) — manual setup guide

**FlowDrop UI** (`flowdrop_ui`) provides the **FlowDrop visual workflow editor** for
Drupal — the Svelte app (bundled from `@flowdrop/flowdrop` 2.x) that other FlowDrop
modules build their tools on. It ships the canvas, nodes, and connections as a
self‑contained bundle and gives Drupal two ways to embed an editor.

The recommended way is the **`flowdrop_editor` render element**: you add it to a render
array, give it a `#base_url`, and it renders the container, attaches the editor
library, and hands per‑instance settings to JavaScript for you — no custom JS and no
`drupalSettings` plumbing. For modules that build their own markup, a small imperative
JavaScript API (`Drupal.flowdropUi.mount()`, `destroy()`, `getApp()`) is also
available. State is kept per instance, so several independent editors can share one
page.

On its own this module renders no admin pages and adds no settings — it is a
**developer/UI foundation library** with no admin UI, routes, permissions, config, or
Drush commands. If you are building on FlowDrop rather than authoring it, you usually
get this module automatically as a dependency.

> **Which version is this?** This is the **2.0.x** line, a breaking rewrite of 1.7.x.
> The old approach exposed a large `window.FlowDrop` global (hundreds of names) that you
> mounted by calling `mountWorkflowEditor()` from a Drupal behavior. In 2.x the
> integration surface is the `flowdrop_editor` render element plus a much smaller
> `Drupal.flowdropUi` API; the `window.FlowDrop` global shrank to about 30 names, state
> became per‑instance, and the old `readOnly` / `lockWorkflow` options collapsed into a
> single `#mode` property. If you are migrating from 1.x, drop your custom mount
> behaviors and switch to the render element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including the detailed
[render‑element](../agent/api/render-element.md) and
[JavaScript API](../agent/api/javascript.md) references.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it is a UI library with no admin
UI, routes, or permissions. Integration happens in code, described below.

## How developers use it

The simplest integration is the render element:

```php
$build['editor'] = [
  '#type' => 'flowdrop_editor',
  '#base_url' => '/api/flowdrop',
  '#height' => '80vh',
];
```

Useful properties include:

- **`#mount`** — `'app'` (default) for the full UI with navbar and sidebars, or
  `'editor'` for just the bare canvas.
- **`#base_url`** — the API base URL the client builds its endpoint map from.
- **`#height`** — the editor height, any CSS length (default `600px`).
- **`#mode`** — `'edit'` (default), `'readonly'`, or `'locked'`.
- **`#workflow`** — a workflow to preload into the editor.
- **`#endpoint_overrides`** / **`#options`** — override generated endpoints or pass
  extra mount options.

For your own markup, mount imperatively with `Drupal.flowdropUi.mount(element, config)`,
tear down with `Drupal.flowdropUi.destroy(element)`, and reach a running app with
`Drupal.flowdropUi.getApp(element)`.
