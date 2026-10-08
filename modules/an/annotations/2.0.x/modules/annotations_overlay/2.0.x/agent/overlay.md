<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Overlay — mechanics

## Service — `AnnotationsOverlayService` (`src/Service/`)

- `loadConsumableAnnotationTypes($account)` — annotation types the account has `consume {id} annotations` for, sorted by weight.
- `loadVisibleAnnotationTypes()` — the above for the current user, then minus the user's own hidden types (`user.data` namespace `annotations_overlay`, key `hidden_types`) when `annotations_overlay.settings:enable_type_hiding` is on. Hiding can only remove, never add.
- `buildDialogsForTarget($target_id, $visible_types, $view_mode='overlay', $rendered_fields=[], $key_prefix='', $include_empty_fields=false)` — loads published annotation entities via `AnnotationStorageService::getEntityMapForTarget($id, TRUE)`, filters to visible types, and returns `target_label`, `bundle_annotations`, `fields_with_annotations`, `empty_fields`, and built `dialogs` render arrays.
- `buildDialog(...)` — a `<dialog>` render element (theme `annotations_overlay_wrapper`) with per-type items (theme `annotations_overlay_item`) rendered through the annotation view builder, plus optional create links. Natively hidden until JS `showModal()`.
- `buildCreateLinks(...)` — "Add {type} annotation" links to `annotations_ui.target.create` for missing, editable types; empty when annotations_ui is absent (route guard) or the user can't edit the type. `field_name` `''` → route sentinel `_overview`.

## Hooks — `AnnotationsOverlayHooks` (`src/Hook/`)

- `form_alter` — on entity add/edit forms, injects a trigger + dialog per in-scope field (requires `view annotations form overlay`). `injectParagraphSubformOverlays()` adds overlays inside inline Paragraphs subforms, prefixing field keys `para__{bundle}__` to avoid collisions; purely structural (no Paragraphs dependency).
- `entity_view_alter` — on rendered displays, attaches view-display overlays (requires `view annotations view overlay`), limited to fields actually rendered in the active display.
- `preprocess_node_add_list` / `preprocess_entity_add_list` — appends bundle-level overview annotations to chooser pages. Builds HTML directly (not `renderInIsolation`, to avoid exhausting the call stack deep in the render pipeline); clones the bundle entity before mutating its description in memory (no save). Annotation values escaped with `nl2br(Html::escape())`; existing admin-authored bundle descriptions filtered with `Xss::filterAdmin()`.
- User-edit form additions let a user pick which consumable types to hide; saved to `user.data` and invalidated via cache tag `annotations_overlay_hidden_types:{uid}`.

## Field plugins (`src/Plugin/Field/`)

- `AnnotationsOverlayFormatter` (`#[FieldFormatter(id: 'annotations_overlay')]`) — `viewElements()` returns `[]`; it exists only to expose the `annotation_view_mode` select in Manage Display (actual rendering is done by the hooks reading that display setting).
- `AnnotationsOverlayItem` (`#[FieldType(id: 'annotations_overlay', no_ui: TRUE)]`) — a computed marker field type, empty schema, `isEmpty()` FALSE.

## Config (`config/install/`, schema `config/schema/annotations_overlay.schema.yml`)

`annotations_overlay.settings`: `show_bundle_chooser_overview` (TRUE), `show_empty_create_links` (FALSE), `enable_type_hiding` (TRUE). View mode `core.entity_view_mode.annotation.overlay`.
