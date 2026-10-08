# Services

- `plugin.manager.quickedit.editor` (`Plugin\InPlaceEditorManager`) — discovers/instantiates
  InPlaceEditor plugins.
- `quickedit.editor.selector` (`EditorSelector`) — picks the best in-place editor for a field,
  given the field's formatter and available editor plugins.
- `quickedit.metadata.generator` (`MetadataGenerator`) — builds the per-field metadata (editor
  id, access, label) sent to the front-end JS.
- `access_check.quickedit.entity_field` (`Access\QuickEditEntityFieldAccessCheck`) — the
  `_access_quickedit_entity_field` route access check; enforces field edit access.

Controllers/AJAX: `QuickEditController` + `QuickEditImageController` back the routes in
`quickedit.routing.yml`; responses use custom AJAX commands under `src/Ajax/`
(`FieldFormCommand`, `FieldFormSavedCommand`, `EntitySavedCommand`, etc.). Layout Builder
support: `LayoutBuilderIntegration` + `Entity\QuickEditLayoutBuilderEntityViewDisplay`.

Most integration is via the plugin type and hooks rather than calling these services directly.
