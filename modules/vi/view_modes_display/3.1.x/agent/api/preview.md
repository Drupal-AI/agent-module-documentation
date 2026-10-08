# Routes & preview service

## Auto-generated routes (per entity type with view modes)

Link templates are set in `EntityTypeInfo::entityTypeAlter()`; `RouteSubscriber::alterRoutes()` builds:

| Route name | Path | Controller method | Requirement |
|---|---|---|---|
| `entity.<type>.vmd_preview_list` | `/{type}/{id}/view-mode/preview/list` | `PreviewController::previewList` | `_permission: preview view modes` |
| `entity.<type>.vmd_preview_render` | `/{type}/{id}/view-mode/preview/{view_mode}` | `PreviewController::previewEntity` | `_permission: preview view modes` |

The list route is an `_admin_route`; the render route is deliberately **not** (so it uses the front-end
theme). `view_mode` defaults to `all` on the list route. Entity is loaded via the `{type}` up-cast
parameter. Requirements are permission-only — **no entity `view` access check** (see the permissions doc).

## `PreviewController`

- `previewList($route_match, $entity_type)` → an `item_list` of links, one per enabled display mode
  (label from view-mode config), each pointing at the render route.
- `previewEntity($route_match, $entity_type)` → renders one view mode wrapped in
  `<div class="view-mode-list-item view-mode-list-item-<mode>">…</div>`; when `view_mode == 'all'` it
  delegates to `PreviewFactory::preview()` to render every enabled mode.

## Service `view_modes_display.preview_factory` (`PreviewFactory`)

- `preview(ContentEntityInterface $entity): array` — render array for all enabled view modes.
- `getEntityDisplays(string $entityTypeId, string $bundle): array` — loads
  `core.entity_view_display.<type>.<bundle>.*` display configs.
- `getEnabledDisplayModes(array $displays): array` — enabled modes; `full` is always appended.
- `buildMarkup(ContentEntityInterface $entity, string $viewMode): array` — renders via the entity view
  builder; **special case:** `block_content` entities are built through
  `block_content:<uuid>` Block plugin instances so blocks preview correctly.

## Other integrations

- `hook_entity_operation()` (`EntityTypeInfo::entityOperation()`) adds a "Preview" operation link
  (weight 100) on entities that have `vmd-preview-list`, gated by `preview view modes`.
- `ViewModeDisplayLocalTask` deriver adds a "View Mode Preview" local task on
  `entity.<type>.canonical`, with a `try/catch` route-exists guard against WSOD during partial cache
  rebuilds.
