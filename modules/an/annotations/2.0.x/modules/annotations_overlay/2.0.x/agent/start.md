<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Overlay (annotations_overlay) — agent index

Triggered inline annotation help overlays on entity forms and view displays. Depends on `annotations`. See [overlay.md](overlay.md) for the injection mechanics.

## Provides

- **Service** `annotations_overlay.service` (`AnnotationsOverlayService`) — `loadVisibleAnnotationTypes()` (consume-perm + per-user hidden), `loadConsumableAnnotationTypes()`, `buildDialogsForTarget()`, `buildDialog()`. Renders annotation entities with view mode `overlay`.
- **Hooks** `annotations_overlay.hooks` (`AnnotationsOverlayHooks`) — `form_alter` (inject triggers/dialogs into entity forms + Paragraphs subforms), `entity_view_alter` (view-display overlays), `preprocess_node_add_list` / `preprocess_entity_add_list` (bundle-chooser overviews), plus user-edit form settings for hiding types.
- **Trigger builder** `AnnotationsOverlayTriggerBuilder::build()` — shared icon markup, reused by annotations_webform and annotations_profile.
- **Field plugins**: `AnnotationsOverlayFormatter` (id `annotations_overlay`) and computed `AnnotationsOverlayItem` field type (`no_ui`) — surface the `annotation_view_mode` setting in Manage Display.
- **Permissions**: `view annotations form overlay`, `view annotations view overlay` (both not restricted).
- **Config**: `annotations_overlay.settings` (`show_bundle_chooser_overview`, `show_empty_create_links`, `enable_type_hiding`); view mode `annotation.overlay`. Schema in `config/schema/`.

## Notes for agents

- Type visibility = `consume {type} annotations` permission minus the user's own `hidden_types` (user.data namespace `annotations_overlay`, gated by `enable_type_hiding`). Cache tag `annotations_overlay_hidden_types:{uid}` invalidates on change.
- Output is server-side rendered and escaped: annotation values via the view builder / `nl2br(Html::escape())`; admin-authored bundle descriptions via `Xss::filterAdmin()` (matching core's own treatment of that config field).
- Create links only appear when `annotations_ui` is installed and the user can edit the missing type.
