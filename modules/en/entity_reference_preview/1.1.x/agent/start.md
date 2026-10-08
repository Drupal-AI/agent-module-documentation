<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Preview (entity_reference_preview) — agent index

Renders **embedded entity references at their latest (draft) revision** while previewing the parent,
so a moderated composition shows its whole draft state. No hard module dependencies (soft Views
integration). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.1.0-beta1** (pre-release).
Configure at `entity_reference_preview.settings` (`/admin/config/content/entity-reference-preview`).

## What it provides

- **Field formatter** `entity_reference_entity_view_preview` ("Rendered entity (with preview)") for
  `entity_reference` fields — the opt-in surface for a reference field. See
  [fields/formatter.md](fields/formatter.md).
- **Preview mechanism**: a `KernelEvents::REQUEST` subscriber sets a per-request "is previewing" flag
  from `preview_detector` plugins; `EntityStateManager` swaps entities to their latest revision.
  See [api/preview-mechanism.md](api/preview-mechanism.md).
- **`preview_detector` plugin type** (annotation `@PreviewDetector`, manager
  `PreviewDetectorPluginManager`) with two plugins: `rendered_entity` (route/entity state) and
  `cookie` (session flag). Fallback plugin id = `rendered_entity`. See
  [plugins/preview-detectors.md](plugins/preview-detectors.md).
- **Manual controls**: toolbar tab (`PreviewDetectorToolbar`), block
  `entity_reference_preview_preview_detector` ("Preview Detector"), and start/stop form
  `PreviewActionsForm` at `/admin/config/content/entity-reference-preview/controls`.
- **Views**: display extender `entity_preview` (opt a display into preview) + the draft indicator,
  driven by `hook_views_post_execute()`. See [api/views-and-indicator.md](api/views-and-indicator.md).
- **Settings + permissions + config schema**. See [config/settings.md](config/settings.md).

## Routes (entity_reference_preview.routing.yml)

- `entity_reference_preview.settings` — settings form; perm `administer entity_reference_preview configuration`.
- `entity_reference_preview.controls` — start/stop preview form; perm `request entity_reference_preview preview`.

## Permissions (entity_reference_preview.permissions.yml)

- `administer entity_reference_preview configuration` (restrict access) — settings + block.
- `request entity_reference_preview preview` — use the manual start/stop controls.
- `view entity_reference_preview indicator` — see the "draft available" indicator.

## Key files

- `src/Plugin/Field/FieldFormatter/EntityReferenceEntityPreviewFormatter.php`
- `src/Entity/EntityStateManager.php`, `src/Events/PreviewNegotiationSubscriber.php`
- `src/PreviewDetectorPluginManager.php`, `src/Plugin/PreviewDetector/*`
- `src/Form/SettingsForm.php`, `src/Form/PreviewActionsForm.php`
- `src/PreviewDetectorToolbar.php`, `src/Plugin/Block/PreviewDetectorBlock.php`
- `src/Plugin/views/display_extender/EntityPreviewDisplayExtender.php`
- `entity_reference_preview.module`, `src/Cache/*CacheContext.php`
