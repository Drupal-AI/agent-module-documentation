<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Paragraphs Toggle Publish (layout_paragraphs_toggle_publish) — agent index

Adds a **publish/unpublish toggle control** to each component in the **Layout Paragraphs** builder,
exposing the published flag that every Paragraph entity already carries. Installed **1.0.2**.
Requires `paragraphs` and **`layout_paragraphs (^2)`**. Core `^8.8 || ^9 || ^10 || ^11`.
License **GPL-2.0-or-later**. Package *Paragraphs*.

## What it is
Layout Paragraphs' built-in controls cover add / edit / move / delete but not *hide this for now*.
This module injects a `Publish`/`Unpublish` link into each component's control bar — a small colored
dot, **green when published / orange when unpublished** — that flips the paragraph's status inline
over AJAX. No config UI, no settings form, no permission of its own, no submodules, no Drush, no JS.

## Complete file inventory
- `layout_paragraphs_toggle_publish.info.yml` — deps `paragraphs:paragraphs`, `layout_paragraphs:layout_paragraphs (^2)`.
- `layout_paragraphs_toggle_publish.module` — `hook_preprocess_layout_paragraphs_builder_controls`
  implementation adds `$variables['controls']['publish_toggle']` from `TogglePublish::getPublishStatusLink()`.
- `layout_paragraphs_toggle_publish.routing.yml` — one route (see api/toggle-route.md).
- `src/Controller/TogglePublish.php` — controller: `toggle()` + static `getPublishStatusLink()`.
- `layout_paragraphs_toggle_publish.libraries.yml` — library `toggle_form` attaching the CSS.
- `css/layout-paragraphs-toggle-publish.css` — the dot indicator classes (see theming/status-indicator.md).
- `README.md`, `LICENSE.txt`. No `*.permissions.yml`, no `*.services.yml`, no `config/`, no `templates/`, no `composer.json`.

## Mechanism in one pass
1. LP builder preprocess adds a render-array link per component. Link classes:
   `is-published`/`not-published` + `lpb-controls-publish-toggle` + `use-ajax`; `#weight` 55.
   Link render-array `#access` = current user has core permission **`view unpublished paragraphs`** (UI visibility only).
2. Click → AJAX **GET** to `layout_paragraphs_toggle_publish.toggle_publish_item`:
   `/layout-paragraphs-toggle-publish/{layout_paragraphs_layout}/toggle-publish/{component_uuid}`,
   `{layout_paragraphs_layout}` loaded from the **per-user tempstore**.
3. `TogglePublish::toggle()` flips `isPublished()`, calls `setNewRevision(TRUE)` and **`->save()` (persists
   immediately)**, writes the layout back to tempstore, and returns an `AjaxResponse` (ReplaceCommand on the
   dot, InvokeCommand `toggleClass paragraph--unpublished`, `LayoutParagraphsEventCommand` `component:update`).

## Access model (the important part)
Route requirement is the parent module's **`_layout_paragraphs_builder_access: 'TRUE'`** (not a flat
permission). With route default `operation: 'update'` and `{component_uuid}` in the path, that checker
(`Drupal\layout_paragraphs\Access\LayoutParagraphsBuilderAccess`) enforces **paragraph-field edit
access AND host-entity update access AND `update` access on the specific paragraph**. So the toggle is
gated to users who may already edit that layout and that paragraph; no unchecked entity is loaded from the
request. See `agent/api/toggle-route.md`.

## Detail docs
- `agent/api/toggle-route.md` — route, controller, access checker resolution, AJAX response.
- `agent/theming/status-indicator.md` — the dot CSS classes and how to restyle.

## Operational gotchas
- An unpublished paragraph is **hidden, not absent**: it keeps its delta, still exports, still reaches
  code reading the field directly. Confirm view modes / decoupled consumers respect the published flag.
- The toggle **saves the paragraph immediately** and creates a revision on each flip — it does not wait
  for the host entity to be saved from the builder.
- Removing the control from a role: revoke `view unpublished paragraphs` (hides the link) and/or restrict
  paragraph/host edit access (blocks the route).
