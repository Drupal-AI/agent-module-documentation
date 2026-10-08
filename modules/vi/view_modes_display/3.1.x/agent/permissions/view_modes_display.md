# View Modes Display permissions

## `preview view modes` (restricted)

`view_modes_display.permissions.yml`:
```yaml
preview view modes:
  title: 'Preview entities in all available view modes'
  description: 'Allows users to preview an entity in all available view modes on a page.'
  restrict access: TRUE
```
Gates: both preview routes (`vmd_preview_list`, `vmd_preview_render`), the entity-operation "Preview"
link, and the canonical local task. `restrict access: TRUE` → intended for trusted site builders only.

## Caveat: preview does not check per-entity view access

The preview routes require **only** the `preview view modes` permission
(`RouteSubscriber::getPreviewRenderRoute()` / `getPreviewList()` add just `_permission`); they do **not**
add an entity `view` access requirement, and `PreviewController` / `PreviewFactory::buildMarkup()` render
the entity through its view builder without an explicit `$entity->access('view')` check. A holder of
`preview view modes` can therefore view the rendered output of any content entity of any type by URL —
including unpublished or otherwise view-restricted entities — as long as they can guess/enumerate the
`/{type}/{id}/view-mode/preview/{view_mode}` path.

This is **not treated as a vulnerability** here because `preview view modes` is a `restrict access: TRUE`
permission (a trusted-admin capability, comparable to core's own broad content-preview powers). Still,
scope the permission tightly: grant it only to roles you would trust to see every entity on the site,
and do not hand it to lower-trust editorial roles expecting normal per-entity access to apply.
