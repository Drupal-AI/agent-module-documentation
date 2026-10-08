# View Modes Display — agent index

Adds a "Preview" tab/operation to every content entity that lets you render it in each enabled view mode.
No config page, no config schema, no Drush. One permission.

- **Routes, the `PreviewController` / `PreviewFactory` service, block_content special case** →
  [api/preview.md](api/preview.md)
- **`preview view modes` permission + the missing per-entity view-access check** →
  [permissions/view_modes_display.md](permissions/view_modes_display.md)

Key facts:
- `hook_entity_type_alter()` adds link templates `vmd-preview-list`
  (`/{entity_type}/{id}/view-mode/preview/list`) and `vmd-preview-render`
  (`/{entity_type}/{id}/view-mode/preview/{view_mode}`) to every entity type with view modes.
- Both routes require permission `preview view modes` (restricted). Controller: `PreviewController`.
- Service `view_modes_display.preview_factory` (`PreviewFactory`) builds the render arrays;
  `block_content` is rendered via the Block plugin, other entities via their view builder.
- Also adds a canonical-page local task and an entity-operation "Preview" link.
