<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Entity Browser (ckeditor5_entity_browser) — agent index

A CKEditor 5 plugin that adds **Entity Browser buttons to the link UI**. Package `CKEditor`.
Version dir **3.0.x** (installed 3.0.3). Core `^10 || ^11`. License GPL-2.0-or-later.
Depends on **`ckeditor5`** and **`entity_browser`**. No composer.json (drupal-only deps).

Provides **no** permissions, routes, services, Drush commands, entities, fields, or config forms of
its own. It contributes one CKEditor 5 plugin (configured per text format) plus glue hooks and an
AJAX command, and reuses Entity Browser's existing UI and routes.

## What it actually is (from source)

- **CKEditor 5 plugin** `linkui_entity_browser.LinkUIEntityBrowser`, declared in
  `ckeditor5_entity_browser.ckeditor5.yml`, PHP side
  `Drupal\ckeditor5_entity_browser\Plugin\CKEditor5Plugin\CkeditorEntityBrowser`. It requires the
  `ckeditor5_link` plugin (`conditions.plugins`), so the buttons live inside the link balloon.
  `elements: false` — it inserts no new markup elements of its own; it only sets the link URL.
- **AJAX command** `Drupal\ckeditor5_entity_browser\Ajax\SetEntityLinkDataCommand` → client command
  `setEntityLinkData` (in `js/scripts/eb_sender.js`), which `postMessage`s the chosen URL to the
  editor document and closes the browser dialog. `js/scripts/eb_parent_receiver.js` receives it.
- **Config schema only** (`config/schema/ckeditor5_entity_browser.schema.yml`) — no `config/install`.
  The plugin settings live on each `editor` entity, key
  `ckeditor5.plugin.ckeditor5_entity_browser_linkui_entity_browser`.
- **Hooks + AJAX callback** in `ckeditor5_entity_browser.module` drive the whole iframe/selection
  flow. One documented alter hook: `hook_ckeditor5_entity_browser_definitions_alter()`
  (`ckeditor5_entity_browser.api.php`).

## Behaviour that matters

- **It inserts a resolved URL, not a stored entity reference.** The selection callback sets the link
  input to `'/' . $entity->toUrl()->getInternalPath()` (e.g. `/node/5`) — convenience, not an
  alias-stable reference. When core's entity-link-suggestions autocomplete (or Linkit) is active in
  the same link UI, the JS nudges it so that path can resolve to an entity link.
- **Only entities with a `canonical` link template can be inserted, one at a time.**

## Solution docs

- **The CKEditor 5 plugin, its per-format settings, config schema & validation** →
  [plugins/entity-browser-linkui.md](plugins/entity-browser-linkui.md)
- **The module hooks, the iframe/AJAX selection flow, and the alter hook** →
  [api/selection-flow.md](api/selection-flow.md)
